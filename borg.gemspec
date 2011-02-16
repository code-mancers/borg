# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{borg}
  s.version = "0.0.19"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hemant Kumar", "Karunakar"]
  s.date = %q{2011-02-16}
  s.default_executable = %q{borg}
  s.description = %q{A distributed Test Suite runner for Rails, using Eventmachine and Redis}
  s.email = %q{hkumar@crri.co.in}
  s.executables = ["borg"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "bin/borg",
    "borg.gemspec",
    "lib/borg.rb",
    "lib/borg/borg_abstract_adapter.rb",
    "lib/borg/borg_config.rb",
    "lib/borg/borg_cucumber.rb",
    "lib/borg/borg_daemon.rb",
    "lib/borg/borg_git.rb",
    "lib/borg/borg_messages.rb",
    "lib/borg/borg_requestor.rb",
    "lib/borg/borg_server.rb",
    "lib/borg/borg_tasks.rake",
    "lib/borg/borg_test_unit.rb",
    "lib/borg/borg_worker.rb",
    "lib/borg/cli.rb",
    "lib/borg/railtie.rb"
  ]
  s.homepage = %q{http://github.com/gnufied/borg}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A distributed Test Suite runner for Rails, using Eventmachine and Redis}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_runtime_dependency(%q<redis>, [">= 0"])
      s.add_runtime_dependency(%q<daemon_controller>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<redis>, [">= 0"])
      s.add_dependency(%q<daemon_controller>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<redis>, [">= 0"])
    s.add_dependency(%q<daemon_controller>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

