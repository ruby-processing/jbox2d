# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Example demonstrating distance joints 
# A bridge is formed by connected a series of particles with joints

require 'pbox2d'
require_relative 'boundary'
require_relative 'pair'
require_relative 'particle'

attr_reader :box2d, :boundaries, :pairs

def setup
  size(640, 360)
  # Initialize box2d physics and create the world
  @box2d = Box2D.new(self)
  box2d.create_world
  @pairs = []
  @boundaries = []
  # Add a bunch of fixed boundaries
  boundaries << Boundary.new(width / 4, height - 5, width / 2 - 50, 10)
  boundaries << Boundary.new(3 * width / 4, height - 50, width / 2 - 50, 10)
end

def draw
  background(255)
  pairs.each(&:display)
  # Display all the boundaries
  boundaries.each(&:display)
  fill(0)
  text('Click mouse to add connected particles.', 10, 20)
end

def mouse_pressed
   pairs << Pair.new(mouse_x, mouse_y)
end
