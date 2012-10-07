require 'minitest/autorun'
require_relative '../lib/pointlist.rb'
class SimplifyTest < MiniTest::Unit::TestCase
  describe "simplify module" do
    it "must do nothing when asked to simplify a one point path" do
      pointlist = PointList.new([[-122.674693498207,45.5474112205939,0]])
      assert_equal(pointlist, pointlist.simplify)
    end
  end
end