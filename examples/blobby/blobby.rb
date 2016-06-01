# The Nature of Code
# <http:#www.shiffman.net/teaching/nature>
# Spring 2012
# Box2DProcessing example

# A blob skeleton
# Could be used to create blobbly characters a la Nokia Friends
# http://postspectacular.com/work/nokia/friends/start

# This seems to be broken with the Box2D 2.1.2 version I'm using

require 'pbox2d'
require 'forwardable'
require_relative 'boundary'
require_relative 'blob'

attr_reader :boundaries, :blob, :box2d

def settings
  size(400, 300)
end

def setup
  sketch_title 'Blobby'  
  # Initialize box2d physics and create the world
  @box2d = WorldBuilder.build(app: self, gravity: [0, -20])
  box2d.create_world
  @boundaries = []
  boundaries << Boundary.new(box2d, Vec2D.new(width / 2, height - 5), Vec2D.new(width, 10))
  boundaries << Boundary.new(box2d, Vec2D.new(width / 2, 5), Vec2D.new(width, 10))
  boundaries << Boundary.new(box2d, Vec2D.new(width - 5, height / 2), Vec2D.new(10, height))
  boundaries << Boundary.new(box2d, Vec2D.new(5, height / 2), Vec2D.new(10, height))
  # Make a new blob
  @blob = Blob.new
end

def draw
  background(255)
  # We must always step through time!
  boundaries.each(&:display)
  # Show the blob!
  blob.display
end
