require 'erb'

class KML
  def initialize(kml_file)
    @file_data = ""
    @point_list = PointList.new([])
    File.open(kml_file, "r") do |file|
      @file_data = file.read
      parse_coordinates
    end
  end
  
  def to_a
    @point_list.tuple_array
  end
  
  def to_encoded
    @point_list.to_s
  end
  
  def simplify!(epsilon=nil, passes=nil)
    original_number_of_coords = @point_list.size
    @point_list = PointList.new(@point_list.tuple_array, epsilon, passes).simplify
    puts "Simplified path from #{original_number_of_coords} to #{@point_list.size} points"
    self
  end
  
  def to_kml
    kml = "No Result."
    File.open("kmlbo/output.kml.erb", "r") do |file|
      mapname = "Kmlbo output"
      template = ERB.new file.read
      kml = template.result(binding)
    end
    kml
  end
  
  private
  def parse_coordinates
    coordinate_string = get_data_between_coordinates_markup
    if coordinate_string != ""
      array_data = convert_string_data_to_array_data(coordinate_string) 
      @point_list = PointList.new(array_data)
    end
  end
  
  def get_data_between_coordinates_markup
    result_string = ""
    data_string = @file_data.split("coordinates")
    if data_string[1]
      result_string = data_string[1][1..-3]
    else
      raise "Invalid KML file: Missing coordinates entity"
    end
    result_string
  end
  
  def convert_string_data_to_array_data(coordinate_string)
    string_tuples = coordinate_string.split(" ").map!{|s| s.strip}
    coordinate_array = string_tuples.map{|tuple| tuple.split(",").map!{|s| s.to_f }}
  end
end