require "bundler"
Bundler.setup

require "rake"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "f00px/version"

task :gem => :build
task :build do
  system "gem build f00px.gemspec"
end

task :install => :build do
  system "gem install f00px-#{F00px::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{F00px::VERSION} -m 'Tagging #{F00px::VERSION}'"
  system "git push --tags"
  system "gem push f00px-#{F00px::VERSION}.gem"
  system "rm f00px-#{F00px::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

RSpec::Core::RakeTask.new('spec:progress') do |spec|
  spec.rspec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
