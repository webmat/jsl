require File.expand_path('../helper', __FILE__)
require 'oj'

class OjTest < Minitest::Test
  def setup
    super
    @aws = Oj::Doc.open File.read( fixtures.join('aws.json') )
    @ohai = Oj::Doc.open File.read( fixtures.join('ohai.json') )
  end
  attr_reader :aws, :ohai

  test "explicit paths" do
    assert_equal 'i-810d04b5', aws.fetch('/Instances/1/InstanceId')
  end

  # Missing 2
  test "size" do
    leaves          = 69
    array_positions = 6
    unknown         = 2
    assert_equal leaves + array_positions + unknown, aws.size
  end

  # test "implicit paths" do
  #   assert_equal 'i-810d04b5', aws.fetch('/Instances/*/InstanceId')
  # end
end
