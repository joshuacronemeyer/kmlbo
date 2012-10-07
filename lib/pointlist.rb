class PointList
  
  attr_accessor :tuple_array
  
  def initialize(tuple_array)
    @tuple_array = tuple_array
  end
  
  def simplify(epsilon=0.01)
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
  
  def dist2(v,w)
    (w[0] - v[0])**2 + (w[1] - v[1])**2
  end
  
  def dist_to_segment_squared(p,v,w)
    l2 = dist2(v, w)
    return dist2(p, v) if l2 == 0
    t = ((p[0] - v[0]) * (w[0] - v[0]) + (p[1] - v[1]) * (w[1] - v[1])) / l2;
    return dist2(p, v) if t < 0
    return dist2(p, w) if t > 1
    return dist2(p, [v[0] + t * (w[0] - v[0]), v[1] + t * (w[1] - v[1])]);
  end
end