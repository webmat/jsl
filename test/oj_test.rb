require File.expand_path('../helper', __FILE__)
require 'oj'

class OjTest < Minitest::Test
  def setup
    super
    @aws = Oj::Doc.open File.read( fixtures.join('aws.json') )
    @ohai = Oj::Doc.open File.read( fixtures.join('ohai.json') )
    @small = Oj::Doc.open(<<-JSON)
    {
      "k1": { "o1k1": "o1v1",
              "o1k2": "o1v2"
            },
      "k2": "v2",
      "k3": 3,
      "k4": { "o4k1": {
        "o4k1k1": "heh"
      } },
      "truek": true
    }
    JSON
  end
  attr_reader :aws, :ohai, :small

  test "explicit paths" do
    assert_equal 'i-deadbeef', aws.fetch('/Instances/1/InstanceId')
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

  test "all leaves" do
    doc = small

    result = {}
    doc.each_leaf() { |leaf| result[leaf.where?] = leaf.fetch() }
    assert_equal "o1v1", result["/k1/o1k1"]
    assert_equal "heh", result["/k4/o4k1/o4k1k1"]
    assert_equal 3, result["/k3"]
  end

  def glob(doc, glob)
    result = {}
    doc.each_leaf() { |leaf|
      if File::fnmatch? glob, leaf.where?
        result[leaf.where?] = leaf.fetch()
      end
    }
    result
  end

  test "glob" do
    doc = small
    assert_equal ['v2'], glob(doc, '/k2').values, '/k2'

    assert_equal ["o1v1"], glob(doc, '/k1/o1k1').values, '/k1/o1k1'
    assert_equal ["o1v1", "o1v2"], glob(doc, '/k1/*').values, '/k1/*'
    assert_equal ["o1v1"], glob(doc, '/*/o1k1').values, '/*/o1k1'

    assert_equal ["o1v1", "o1v2"], glob(doc, '/k1/o1k?').values, '/k1/o1k?'

    assert_equal ["i-deadbeef"], glob(aws, '**/InstanceId').values, '**/InstanceId'
  end

  def jsl(doc, arg)
    if '/' == arg[0]
      g = arg
    else
      g = "**/#{arg}"
    end
    results = glob(doc, g)
    results.values
  end

  test "jsl cli API" do
    doc = aws
    assert_equal ["i-deadbeef"], jsl(doc, "InstanceId")
    assert_equal [], jsl(doc, "/InstanceId")
    assert_equal ["i-deadbeef"], jsl(doc, "**/InstanceId")

    doc = Oj::Doc.open <<-JSON
    { "a": { "key": "valueA" }
    , "b": { "key": "valueB" }
    }
    JSON
    assert_equal ["valueA", "valueB"], jsl(doc, "key")
  end
end
