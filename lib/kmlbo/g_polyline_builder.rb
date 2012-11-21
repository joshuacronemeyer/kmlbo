class GPolylineBuilder
  include GPolyline
  
  attr_reader :points
  def initialize(preexisting="")
    @points = Decoder.new(preexisting).do
    @encoding = preexisting
  end
  
  def gpolyline_points
    @points
  end
  
  def <<(tuple)
    @points << tuple
    self.to_s
  end
  
  def shift
    @points.shift
  end
  
  def encode
    self.to_s
  end
  
  class Decoder
    
    def initialize(characters)
      @characters = characters
    end
    
    def do
      decompose
    end
    
    def decompose
      set = []
      return @characters.split(//).inject([]) do |charset, char|
        set << char
        if ((char.unpack("U").first - 63) & 0x20).zero?
          charset << set.join
          set = []
        end
        charset
      end.map {|charset| decode(charset) }
    end
  end
end