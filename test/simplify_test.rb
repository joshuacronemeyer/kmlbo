require 'minitest/autorun'
require_relative '../lib/pointlist.rb'
require_relative 'data.rb'
class SimplifyTest < MiniTest::Unit::TestCase
  describe "simplify module" do
    it "must do nothing when asked to simplify a one point path" do
      pointlist = PointList.new([[-122.674693498207,45.5474112205939,0]])
      pointlist.simplify.must_equal pointlist
    end
    
    it "must do nothing to simplify a two point path" do
      pointlist = PointList.new([[-122.674693498207,45.5474112205939,0], [-122.7118673141142,45.55102912532022,0]])
      pointlist.simplify.must_equal pointlist
    end
    
    it "must simplify a three point path without interesting features" do
      expected_pointlist = PointList.new([[-122.5681339459179,45.51082979610937,0], [-122.6426949487332,45.53644162775804,0]])
      pointlist = PointList.new([[-122.5681339459179,45.51082979610937,0], [-122.6079738253994,45.51996961684905,0], [-122.6426949487332,45.53644162775804,0]])
      pointlist.simplify.must_equal pointlist
    end
    
    it "must behave in a reasonable manner on a real dataset" do
      pointlist = PointList.new(Data::PATH)
      simplified = pointlist.simplify(0.0001)
      assert(simplified.tuple_array.length > 0)
      assert(simplified.tuple_array.length < Data::PATH.length)
    end
  end
end