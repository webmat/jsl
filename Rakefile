$LOAD_PATH.unshift "./lib"
require "bundler/gem_tasks"

require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

task :default => :test

def camelize(string)
  string.split('_').map(&:capitalize).join
end

namespace :test do
  desc "Create a new test file: rake test:new[file_name]"
  task :new, [:file_name] do |t, args|
    file_name   = args[:file_name]
    full_name   = File.expand_path("../test/#{file_name}_test.rb", __FILE__)
    `mkdir -p #{File.dirname(full_name)}`
    class_name  = camelize(file_name)
    abort "File exists: #{full_name}" if File.exists?(full_name)

    File.open(full_name, 'w') do |f|
      f.write <<-FILE
require File.expand_path('../helper', __FILE__)
require 'servus/#{file_name}'

class #{class_name}Test < Minitest::Test
  test "should test #{class_name}" do
    flunk "I haven't tested #{class_name} yet"
  end
end
      FILE
      puts "Created #{full_name}"
    end
  end
end
