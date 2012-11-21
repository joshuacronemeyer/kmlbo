require File.join(File.dirname(__FILE__), 'test_helper')
# all expected values for these tests were computed using google's API
# https://developers.google.com/maps/documentation/utilities/polylineutility
class GPolylineTest < MiniTest::Unit::TestCase
 describe "to_s" do
   it "must correctly convert a one element polyline" do
     pointlist = PointList.new([[-94.4243478,39.13594499],[-94.4243471,39.13558757]])
     pointlist.to_s.must_equal "svzmFdgi_QdA?"
   end

   # it "must convert a multipart line" do
   #   path = [ [-94.42434787909789,39.13594499803094,0], [-94.42434713169446,39.1355875721549,0], [-94.424343522331,39.13486866498771,0] ]
   #   expected = "svzmFdgi_QdA?nCA"
   #   pointlist = PointList.new(path)
   #   pointlist.to_s.must_equal expected
   # end
  end
end