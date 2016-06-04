# The Nature of Code
# <http://www.shiffman.net/teaching/nature>
# Spring 2012
# Box2DProcessing example

# A blob skeleton
# Could be used to create blobbly characters a la Nokia Friends
# http://postspectacular.com/work/nokia/friends/start

require 'pbox2d'
require 'forwardable'
require_relative 'lib/boundary'
require_relative 'lib/bubble_factory'
require_relative 'lib/bubble'


attr_reader :boundaries, :box2d, :bubble, :bubble1, :bubble2, :bubble_factory

def settings
  size(400, 400)
end

def setup
  sketch_title 'Bubbles'  
  # Initialize box2d physics and create the world
  @box2d = WorldBuilder.build(app: self, gravity: [0, 30])
  box2d.create_world
  @boundaries = []
  boundaries << Boundary.new(box2d, Vect.new(160, 135), Vect.new(20, height * 0.21))
  boundaries << Boundary.new(box2d, Vect.new(240, 135), Vect.new(20, height * 0.21))
  boundaries << Boundary.new(box2d, Vect.new(130, 190), Vect.new(80, 20), 0.5)
  boundaries << Boundary.new(box2d, Vect.new(270, 190), Vect.new(80, 20), -0.5)
  boundaries << Boundary.new(box2d, Vect.new(100, height * 0.9), Vect.new(20, height * 0.8))
  boundaries << Boundary.new(box2d, Vect.new(300, height * 0.9), Vect.new(20, height * 0.8))
  @bubble_factory = BubbleFactory.new(xrange: (145..255))
  @bubble = bubble_factory.create_bubble(height: height - 20, hue: 255)
  @bubble1 = bubble_factory.create_bubble(height: height + 20, hue: 255)
  @bubble2 = bubble_factory.create_bubble(height: height + 60, hue: 255)
end

def draw
  background(0, 0, 255)

  boundaries.each(&:display)
  # Show the blobs! 
  @bubble = bubble_factory.create_bubble(height: height - 20, hue: 255) if ((frame_count % 240) == 0)
  bubble.display
  @bubble1 = bubble_factory.create_bubble(height: height + 20, hue: 255) if ((frame_count % 280) == 0)
  bubble1.display
  @bubble2 = bubble_factory.create_bubble(height: height + 60, hue: 255) if ((frame_count % 320) == 0)
  bubble2.display
end
