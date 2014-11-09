require 'pbox2d'

# A list we'll use to track fixed objects
attr_reader :box2d, :boundaries, :boxes

java_alias :background_int, :background, [Java::int]
java_alias :stroke_int, :stroke, [Java::int]

def setup
  size(400,300)
  stroke_int(0)  # set stroke this way to avoid overload warnings
  srand(5)
  # Initialize box2d physics and create the world
  @box2d = Box2D.new(self)
  puts box2d.version # print out version of pbox2d gem in use
  box2d.init_options(scale: 10, gravity: [0, -20.0])
  box2d.create_world
  # Set a custom gravity
  # box2d.gravity(0, -20)  
  # Create ArrayLists	
  @boxes = []
  @boundaries = []  
  # Add a bunch of fixed boundaries
  boundaries << Boundary.new(box2d, width / 4, height - 5, width / 2 - 50, 10)
  boundaries << Boundary.new(box2d, 3 * width / 4, height - 50, width / 2 - 50, 10)
end

def draw
  background_int(255) # set background this way to avoid overload warnings 
  # Boxes fall from the top every so often
  boxes << Box.new(box2d, width / 2, 30) if rand < 0.99
  boundaries.each(&:display)  
  boxes.each(&:display)  
  # Boxes that leave the screen, we delete them note they have to be deleted 
  # from both the box2d world and locally  
  boxes.reject!(&:done)  
  exit if frame_count >= 908
end

class Boundary
  include Processing::Proxy
  # A boundary is a simple rectangle with x, y, width, and height
  attr_reader :box2d, :x, :y, :w, :h, :b 
  
  def initialize(box2d, x ,y, w, h)
    @box2d, @x ,@y, @w, @h = box2d, x ,y, w, h    
    # Create the body
    bd = BodyDef.new
    bd.position.set(box2d.processing_to_world(x, y))
    @b = box2d.create_body(bd)    
    # Figure out the box2d coordinates
    box2d_w = box2d.scale_to_world(w / 2)
    box2d_h = box2d.scale_to_world(h / 2)    
    # Define the polygon
    sd = PolygonShape.new
    sd.setAsBox(box2d_w, box2d_h)    
    fd = FixtureDef.new
    fd.shape = sd
    fd.density = 0
    fd.friction = 0.3
    fd.restitution = 0.5    
    b.createFixture(fd)    
  end
  
  # Draw the boundary, if it were at an angle we'd have to do something fancier
  def display
    fill(0)
    rect_mode(CENTER)
    rect(x, y, w, h)
  end  
end

# A rectangular box
class Box
  include Processing::Proxy
  # We need to keep track of a Body and a width and height
  attr_reader :box2d, :body, :w, :h
  
  # Constructor
  def initialize(b2d, x, y)
    @w = rand(4..16)
    @h = rand(4..16)
    @box2d = b2d
    # Add the box to the box2d world
    make_body(Vec2.new(x, y), w, h)
  end
  
  def done
    # Let's find the screen position of the particle
    pos = box2d.body_coord(body)
    # Is it off the bottom of the screen?
    return false unless (pos.y > box2d.height + w * h)
    box2d.destroy_body(body)
    true
  end
  
  # Drawing the box
  def display
    # We look at each body and get its screen position
    pos = box2d.body_coord(body)
    # Get its angle of rotation
    a = body.angle    
    rect_mode(CENTER)
    push_matrix
    translate(pos.x, pos.y)
    rotate(-a)
    fill(175)
    rect(0, 0, w, h)
    pop_matrix
  end
  
  # This function adds the rectangle to the box2d world
  def make_body(center, w, h)    
    # Define a polygon (this is what we use for a rectangle)
    sd = PolygonShape.new
    box2d_w = box2d.scale_to_world(w / 2)
    box2d_h = box2d.scale_to_world(h / 2)
    sd.setAsBox(box2d_w, box2d_h)    
    # Define a fixture
    fd = FixtureDef.new
    fd.shape = sd
    # Parameters that affect physics
    fd.density = 1
    fd.friction = 0.3
    fd.restitution = 0.5    
    # Define the body and make it from the shape
    bd = BodyDef.new
    bd.type = BodyType::DYNAMIC
    bd.position.set(box2d.processing_to_world(center))    
    cs = CircleShape.new
    @body = box2d.create_body(bd)
    body.create_fixture(fd)
    # Give it some initial random velocity
    body.setLinearVelocity(Vec2.new(rand(-5.0..5), rand(2.0..5)))
    body.setAngularVelocity(rand(-5.0..5))
  end
end
