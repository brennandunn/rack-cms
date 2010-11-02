# -*- encoding: utf-8 -*-
require File.expand_path("../lib/rack/cms/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-cms"
  s.version     = Rack::Cms::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brennan Dunn"]
  s.email       = ["me@brennandunn.com"]
  s.homepage    = "http://rubygems.org/gems/rack-cms"
  s.summary     = "TODO: Write a gem summary"
  s.description = "TODO: Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rack-cms"

  s.add_dependency "activesupport",  ">= 3.0.0"
  s.add_dependency "redis",          ">= 2.0.13"
  s.add_dependency "sinatra",        ">= 1.0"

  s.add_development_dependency "bundler",   ">= 1.0.0"
  s.add_development_dependency "cucumber",  ">= 0.9.3"
  s.add_development_dependency "rspec",     "~> 1.3.0"
  s.add_development_dependency "webrat",    ">= 0.7.2"
  s.add_development_dependency "rake",      ">= 0.8.7"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
