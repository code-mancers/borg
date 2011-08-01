module Borg
  class Worker < EM::Connection
    include EM::P::ObjectProtocol
    @@status_reports = []

    def receive_object(ruby_object)
      case ruby_object
      when StartBuild
        update_code(ruby_object)
      when StartTest
        start_test
      end
    end

    def connection_completed
      send_object(WorkerConnected.new(self.signature,
        :test_unit_processes => Borg::Config.test_unit_processes,
        :cucumber_processes  => Borg::Config.cucumber_processes,
        :rspec_processes     => Borg::Config.rspec_processes
      ))
    end

    def unbind
      EM.add_timer(3) {
        reconnect(Borg::Config.ip,Borg::Config.port)
      }
    end

    def update_code(build_request)
      source_control = Borg::Git.new()
      source_control.update(build_request.sha)
      if(source_control.status)
        start_test
      else
        send_object(BuildStatus.new(1))
      end
    end

    def redis
      Redis.new(:host => Borg::Config.redis_ip,:port => Borg::Config.redis_port)
    end

    def start_test
      if(redis.llen("tests") > 0)
        EM.popen("rake borg:test RAILS_ENV=test", TestRunner) do |process|
          process.worker = self
          process.runner_type = 'unit'
        end
      else
        start_cucumber(BuildStatus.new(0))
      end
    end

    def start_cucumber(last_status)
      @@status_reports << last_status
      if(redis.llen("cucumber") > 0)
        EM.popen("rake borg:cucumber RAILS_ENV=cucumber",TestRunner) do |process|
          process.worker = self
          process.runner_type = 'cucumber'
        end
      else
        send_final_report(BuildStatus.new(0))
      end
    end

    def send_final_report(last_status)
      @@status_reports << last_status
      p @@status_reports
      error_flag = @@status_reports.any? {|x| x.exit_status != 0}

      if(error_flag)
        send_object(BuildStatus.new(1))
      else
        send_object(BuildStatus.new(0))
      end
      @@status_reports = []
    end
  end

  class TestRunner < EM::Connection
    attr_accessor :worker
    attr_accessor :runner_type

    include EM::P::ObjectProtocol
    def receive_data(data)
      worker.send_object(BuildOutput.new(data))
    end

    def unbind
      puts "Sending the status thingy"
      if(runner_type == 'unit')
        worker.start_cucumber(BuildStatus.new(exit_status))
      else
        worker.send_final_report(BuildStatus.new(exit_status))
      end
    end

    def exit_status
      if(get_status.exitstatus)
        get_status.exitstatus
      else
        1
      end
    end

  end
end
