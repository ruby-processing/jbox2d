# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# This class avoids test for nil
class DummySpring
  def initialize; end

  # If it exists we set its target to the mouse location
  def update(_x, _y); end

  def display; end

  # This is the key function where
  # we attach the spring to an x,y location
  # and the Box object's location
  def bind(x, y, box)
    spring = Spring.new
    spring.bind(x, y, box)
    spring
  end

  def destroy; end
end
