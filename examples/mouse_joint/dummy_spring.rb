# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# This class avoids test for nil
class DummySpring
  def initialize; end
  def update(_x, _y); end
  def display; end
  # This is the key function where
  # we attach the spring to an x,y location
  # and the box object's location
  # @param x (will be mouse_x)
  # @param y (will be mouse_y)
  # @return new bound spring
  def bind(x, y, box)
    spring = Spring.new
    spring.bind(x, y, box)
    spring
  end

  def destroy; end
end
