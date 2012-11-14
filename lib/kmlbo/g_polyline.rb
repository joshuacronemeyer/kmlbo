# GPolyline is a module that implements the Google Polyline Algorithm Format.
# https://developers.google.com/maps/documentation/utilities/polylinealgorithm
#
# Author:: Josh Cronemeyer
# Copyright:: Copyright (c) 2008-2011
# License:: MIT License (http://www.opensource.org/licenses/mit-license.php)
#
# Include this module into a class that has an instance variable called
# @tuple_array, where @tuple_array contains a list of geocoordinates of the
# form [[lng, lat, elev], ..., [lng, lat, elev]].  It will override to_s
# and output an encoded path suitable for use in Google Maps v3 API
#
#   require "kmlbo/g_polyline"
#   class Polyline
#     include GPolyline
#     ...
#   end
#
#   path = Polyline.new
#   path.to_s
#   # => "svzmFdgi_QdA?nCA"
#
# Ideas for this implementation of the google polyline algorithm format
# come from the following sources:
# * http://facstaff.unca.edu/mcmcclur/GoogleMaps/
# * https://github.com/joshuaclayton/polylines/
#
# This implementation is tested against results from the Google API to
# ensure compatability.  See unit tests for more information.

module GPolyline
  # Output an encoded path String suitable for use in Google Maps v3 API
  def to_s
    encode_polyline_algorithm
  end
  
  private
  def encode_polyline_algorithm
    deltas.map {|point| encode_signed_decimal(point) }.join
  end
  
  def round_decimal(decimal)
    (decimal * 1e5).round
  end
  
  def encode_signed_decimal(num)
    sgn_num = num << 1
    sgn_num = ~sgn_num if num < 0 
    return encode_number(sgn_num)
  end

  def to_e5
    @tuple_array.map do |tuple|
      tuple.map{|coordinate| round_decimal(coordinate)}
    end
  end
  
  def deltas
    delta_latitude, delta_longitude = 0, 0

    return to_e5.inject([]) do |polyline, (longitude, latitude)|
      polyline << latitude - delta_latitude
      polyline << longitude - delta_longitude
      delta_latitude, delta_longitude = latitude, longitude
      polyline
    end
  end
  
  def encode_number(num)
    encoded = ""
    while (num >= 0x20) do
        encoded << ((0x20 | (num & 0x1f)) + 63).chr
        num = num >> 5
    end
    encoded << (num + 63).chr
    return encoded
  end
end