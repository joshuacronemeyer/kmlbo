require File.join(File.dirname(__FILE__), 'test_helper')
class GPolylineBuilderTest < MiniTest::Unit::TestCase
 describe "append coordinate" do
   
    it "must correctly add a coordinate to empty line" do
      line = GPolylineBuilder.new
      line << [-122.674693498207,45.5474112205939]
      line.encode.must_equal "i~~tGx{vkV"
    end

    it "must always returns the encoding" do
      line = GPolylineBuilder.new
      return_value = line << [-122.674693498207,45.5474112205939]
      return_value.must_equal "i~~tGx{vkV"
    end

    it "must use offset for the second point" do
      line = GPolylineBuilder.new
      line << [-94.42434787909789,39.13594499803094,0]
      line << [-94.42434713169446,39.1355875721549,0]
      line.encode.must_equal "svzmFdgi_QdA?"
    end
  
  end
  describe "remove the head of the path" do
  
    it "must remove the coordinate" do
      line = GPolylineBuilder.new
      line << [-94.42434787909789,39.13594499803094,0]
      line << [-94.42434713169446,39.1355875721549,0]
      line.shift
      line.encode.must_equal "mtzmFdgi_Q"
    end
  
  end
  describe "initialize a builder with preexisting path data" do
  
    it "should preserve preexisting data" do
      line = GPolylineBuilder.new("svzmFdgi_QdA?")
      line.encode.must_equal "svzmFdgi_QdA?"
    end
  
  end
end