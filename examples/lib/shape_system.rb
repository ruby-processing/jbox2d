# custom runnable module
module Runnable
  def run
    reject!(&:done)
    each(&:display)
  end
end

# using forwardable to make a custom enumerable
class ShapeSystem
  include Enumerable, Runnable
  extend Forwardable
  def_delegators(:@polygons, :each, :reject!, :<<)

  attr_reader :bd

  def initialize(bd)
    @bd = bd
    @polygons = [] # Initialize the Array
  end

  def add_polygon(x, y)
    self << CustomShape.new(bd, x, y)
  end
end
