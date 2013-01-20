# -*- encoding: utf-8 -*-
#lib = File.expand_path('../lib/', __FILE__)
#$:.unshift lib unless $:.include?(lib)
require File.expand_path('../lib/raiskeleton/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Fábio Maia"]
  gem.email         = ["fabioromm@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "raiskeleton"
  gem.require_paths = ["lib"]
  gem.version       = Raiskeleton::VERSION

  gem.add_dependency "actionpack",  "~> 3.0"
  gem.add_dependency "cells", "~> 3.8.5"

  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake'
end
