class PointList
  
  attr_accessor :tuple_array
  
  def initialize(tuple_array)
    @tuple_array = tuple_array
  end
  
  def simplify(epsilon=0.000001)
    return PointList.new(douglas_peucker(@tuple_array, epsilon))
  end
  
  def ==(other)
    return true if other.equal?(self)
    return false unless other.instance_of?(self.class)
    @tuple_array == other.tuple_array
  end
  
  private
  def douglas_peucker(point_list, epsilon)
    #http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm
    maximum_distance_of_point = 0
    index_of_point = 0
    point_list[1..-1].each_with_index do |point, index|
      distance = perpendicular_distance(point, point_list)
      if distance > maximum_distance_of_point
        index_of_point = index + 1
        maximum_distance_of_point = distance
      end
    end
    if maximum_distance_of_point >= epsilon
      douglas_peucker(point_list[0..index_of_point - 1],epsilon) + douglas_peucker(point_list[index_of_point + 1..-1], epsilon)
    else
      point_list
    end
  end
  
  def perpendicular_distance(point, point_list)
    distance = Math.sqrt(dist_to_segment_squared(point, point_list.first, point_list.last))
    return distance
  end
  
  def magnitude(v,w)
    (w[0] - v[0])**2 + (w[1] - v[1])**2
  end
  
  def dist_to_segment_squared(point,seg_start,seg_end)
    l2 = magnitude(seg_start, seg_end)
    return magnitude(point, seg_start) if l2 == 0
    t = ((point[0] - seg_start[0]) * (seg_end[0] - seg_start[0]) + (point[1] - seg_start[1]) * (seg_end[1] - seg_start[1])) / l2;
    return magnitude(point, seg_start) if t < 0
    return magnitude(point, seg_end) if t > 1
    return magnitude(point, [seg_start[0] + t * (seg_end[0] - seg_start[0]), seg_start[1] + t * (seg_end[1] - seg_start[1])]);
  end
end