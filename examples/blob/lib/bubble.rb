# The Nature of Code
# <http://www.shiffman.net/teaching/nature>
# Spring 2012
# Box2DProcessing example

# A blob skeleton
# Could be used to create blobbly characters a la Nokia Friends
# http://postspectacular.com/work/nokia/friends/start

class Bubble
  include Processing::Proxy
  # A list to keep track of all the points in our blob
  attr_reader :outline, :radius, :total_points, :hue
  # We should modify this constructor to receive arguments
  # So that we can make many different types of blobs
  
  def initialize(pos:, hue:)
    # Create the empty outline
    @outline = [] 
    @hue = hue
    # Let's make a volume of joints!
    cvjd = ConstantVolumeJointDef.new
    # Where and how big is the blob
    center = Vec2.new(pos.x, pos.y)
    @total_points = 150
    @radius = 25
    # Initialize all the points
    total_points.times do |i|
      # Look polar to cartesian coordinate transformation!
      theta = map1d(i, 0..total_points, 0..TWO_PI)
      x = center.x + radius * sin(theta)
      y = center.y + radius * cos(theta)
      # Make each individual body
      bd = BodyDef.new
      bd.type = BodyType::DYNAMIC
      bd.fixedRotation = true # no rotation!
      bd.position.set(box2d.processing_to_world(Vec2.new(x, y)))
      body = box2d.createBody(bd)
      # The body is a circle
      cs = CircleShape.new
      cs.m_radius = box2d.scale_to_world(0)
      # Define a fixture
      fd = FixtureDef.new
      fd.shape = cs
      # For filtering out collisions
      #fd.filter.groupIndex = -2
      # Parameters that affect physics
      fd.set_density(1.0)
      fd.set_restitution(0.5)
      fd.set_friction(0.5)
      # Finalize the body
      body.create_fixture(fd)
      # Add it to the volume
      cvjd.add_body(body)
      # Store our own copy for later rendering
      outline << body
   end
    # These parameters control how stiff vs. jiggly the blob is
    cvjd.frequencyHz = 0.0
    cvjd.dampingRatio = 0.0
    # Put the joint thing in our world!
    box2d.world.create_joint(cvjd)
 end
 
  # Time to draw the blob!
  # Can you make it a cute character, a la 
  # http://postspectacular.com/work/nokia/friends/start
  def display
    # Draw the outline
    begin_shape
    fill(hue)
    stroke(0, 0, 255)
    stroke_weight(0)
    outline.each do |b|
      pos = box2d.body_coord(b)
      vertex(pos.x, pos.y)
    end
    end_shape(CLOSE)
 end
end
