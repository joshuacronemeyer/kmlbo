class PointList
  
  attr_accessor :tuple_array
  
  def initialize(tuple_array)
    @tuple_array = tuple_array
  end
  
  def simplify
    return PointList.new(@tuple_array)
  end
  
  def ==(other)
    return true if other.equal?(self)
    return false unless other.instance_of?(self.class)
    @tuple_array == other.tuple_array
  end
end