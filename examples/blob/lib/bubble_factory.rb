Vect = Struct.new(:x, :y)

class BubbleFactory
  attr_reader :xrange
  def initialize(xrange:)
    @xrange = xrange
  end
  
  def create_bubble(hue:, height:)
    Bubble.new(pos: Vect.new(rand(xrange), height), hue: hue)
  end
end
