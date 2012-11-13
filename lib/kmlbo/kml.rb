require 'erb'

class KML
  def initialize(kml_file)
    @coordinates = []
    @file_data = ""
    File.open(kml_file, "r") do |file|
      @file_data = file.read
      parse_coordinates
    end
  end
  
  def to_a
    @coordinates
  end
  
  def simplify!(epsilon=nil, passes=nil)
    original_number_of_coords = @coordinates.size
    @coordinates = PointList.new(@coordinates, epsilon, passes).simplify.tuple_array
    puts "Simplified path from #{original_number_of_coords} to #{@coordinates.size} points"
    self
  end
  
  def to_kml
    kml = "No Result."
    File.open("lib/kmlbo/output.kml.erb", "r") do |file|
      mapname = "The Oregon Twail"
      template = ERB.new file.read
      kml = template.result(binding)
    end
    kml
  end
  
  private
  def parse_coordinates
    coordinate_string = get_data_between_coordinates_markup
    @coordinates = convert_string_data_to_array_data(coordinate_string) if coordinate_string != ""
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