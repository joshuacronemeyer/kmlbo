require 'minitest/autorun'
require 'kmlbo'

# all expected values for these tests were computed using google's API
# https://developers.google.com/maps/documentation/utilities/polylineutility
class GPolylineTest < MiniTest::Unit::TestCase
 describe "polyline module" do
   it "must correctly convert a one element polyline" do
     pointlist = PointList.new([[-122.674693498207,45.5474112205939,0]])
     pointlist.to_s.must_equal "i~~tGx{vkV"
   end

   it "must convert a multipart line" do
     path = [ [-94.42434787909789,39.13594499803094,0], [-94.42434713169446,39.1355875721549,0], [-94.424343522331,39.13486866498771,0] ]
     expected = "svzmFdgi_QdA?nCA"
     pointlist = PointList.new(path)
     pointlist.to_s.must_equal expected
   end
  end
end