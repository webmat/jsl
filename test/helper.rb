require 'rubygems'
require 'bundler'
Bundler.require(:default, :development, :test)

require 'pp'
require 'pathname'

require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'    # colorize output
require "minitest/hell"     # parallel all tests

require 'mocha/setup'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

class Minitest::Test
  # Swap out stdout and stderr for each test run.
  # Read their content simply by calling "stdout" or "stderr" from your test.
  def setup
    @real_stdout = $stdout
    @real_stderr = $stderr
    $stdout = StringIO.new
    $stderr = StringIO.new
  end

  def teardown
    $stdout = @real_stdout
    $stderr = @real_stderr
  end

  def stdout
    $stdout.string
  end

  def stderr
    $stderr.string
  end

  def fixtures
    Pathname.new('test/fixtures/')
  end

  class << self # The def self.test way of doing it doesn't override Kernel.test but this does...

    # Helper to write test names declaratively:
    #   test "my thing" do
    # instead of
    #   def test_my_thing
    def test(name, &block)
      method_name = "test_#{ name.gsub(/[\W]/, '_') }"
      if block.nil?
        define_method(method_name) do
          flunk "Missing implementation for test #{name.inspect}"
        end
      else
        define_method(method_name, &block)
      end
    end # def test

  end # class << self
end
