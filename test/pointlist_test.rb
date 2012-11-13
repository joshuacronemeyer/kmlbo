require 'minitest/autorun'
require_relative '../lib/kmlbo/pointlist.rb'
require_relative 'data.rb'
class PointlistTest < MiniTest::Unit::TestCase
  describe "simplify module" do
    it "must do nothing when asked to simplify a one point path" do
      pointlist = PointList.new([[-122.674693498207,45.5474112205939,0]])
      pointlist.simplify.must_equal pointlist
    end
    
    it "must do nothing to simplify a two point path" do
      pointlist = PointList.new([[-122.674693498207,45.5474112205939,0], [-122.7118673141142,45.55102912532022,0]])
      pointlist.simplify.must_equal pointlist
    end
    
    it "must simplify a three point path" do
      expected_pointlist = PointList.new([[-122.56,45.51,0], [-122.64,45.53,0]])
      pointlist = PointList.new([[-122.56,45.51,0], [-122.60,45.51,0], [-122.64,45.53,0]])
      pointlist.simplify.must_equal expected_pointlist
    end
    
    it "will not simplify a three point path when epsilon is larger than distance to outlier" do
      expected_pointlist = PointList.new([[1,1,0], [2,2,0], [3,1,0]])
      distance_to_outlier = Math.sqrt(2)
      epsilon = distance_to_outlier + 0.0001
      pointlist = PointList.new([[1,1,0], [2,2,0], [3,1,0]], epsilon, 1)
      pointlist.simplify.must_equal expected_pointlist
    end
    
    it "will simplify a three point path when epsilon is exactly the distance to outlier" do
      expected_pointlist = PointList.new([[1,1,0], [3,1,0]])
      distance_to_outlier = Math.sqrt(2)
      pointlist = PointList.new([[1,1,0], [2,2,0], [3,1,0]], distance_to_outlier, 1)
      pointlist.simplify.must_equal expected_pointlist
    end
    
    it "must leave the start, end and furthest outlier on a five point path" do
      expected_pointlist = PointList.new([[0,0,0], [2,2,0], [4,0,0]])
      pointlist = PointList.new([[0,0,0], [1,1,0], [2,2,0], [3,1,0], [4,0,0]])
      pointlist.simplify.must_equal expected_pointlist
    end
    
    it "2 passes of d-p will simplify 5 point path to 2 points" do
      expected_pointlist = PointList.new([[0,0,0], [4,0,0]])
      pointlist = PointList.new([[0,0,0], [1,1,0], [2,2,0], [3,1,0], [4,0,0]], nil, 2)
      pointlist.simplify.must_equal expected_pointlist
    end
    
    it "must behave in a reasonable manner on a real dataset" do
      pointlist = PointList.new(Data::PATH)
      simplified = pointlist.simplify
      assert(simplified.tuple_array.length > 0)
      assert(simplified.tuple_array.length < Data::PATH.length)
    end
  end
end