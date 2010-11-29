# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "exceptions_begone_notifier/version"

Gem::Specification.new do |s|
  s.name        = "exceptions_begone_notifier"
  s.version     = ExceptionsBegoneNotifier::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Patryk Peszko"]
  s.email       = ["developers@xing.com"]
  s.homepage    = "http://github.com/ppeszko/exceptions_begone_notifier"
  s.summary     = "Catch and send exceptions to exceptions_begone service"
  s.description = "Catch and send exceptions to exceptions_begone service"

  s.rubyforge_project = "exceptions_begone_notifier"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "rails", "~> 2.3.8"
  s.add_development_dependency "rcov", "> 0"
  s.add_development_dependency "mocha", "> 0"
end
