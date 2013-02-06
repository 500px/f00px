# -*- encoding: utf-8 -*-
require File.expand_path('../lib/f00px/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "f00px"
  gem.version       = F00px::VERSION
  gem.authors       = ["Arthur Neves"]
  gem.email         = ["arthurnn@gmail.com"]
  gem.homepage      = ""
  gem.summary       = "500px api rubygem"
  gem.description   = ""

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.files         = `git ls-files`.split($\)
  gem.require_paths = ["lib"]

  gem.required_ruby_version     = ">= 1.9"
  gem.required_rubygems_version = ">= 1.3.6"
  gem.rubyforge_project         = "f00px"

  gem.add_dependency("faraday_middleware", ["~> 0.9.0"])
  gem.add_dependency("typhoeus", ["~> 0.5.4"])
  gem.add_dependency("simple_oauth", ["~> 0.2.0"])

end
