#!/usr/bin/env rake
require "bundler/gem_tasks"
#Bundler::GemHelper.install_tasks
require 'rake/testtask'
task :default => :test

Rake::TestTask.new(:test) do |test|
    test.libs << 'lib/raiskeleton'
    test.test_files = FileList['test/unit/raiskeleton/*_test.rb']
    #test.verbose = true
end
