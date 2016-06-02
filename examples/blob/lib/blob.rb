# The Nature of Code
# <http://www.shiffman.net/teaching/nature>
# Spring 2012
# Box2DProcessing example

# A blob skeleton
# Could be used to create blobbly characters a la Nokia Friends
# http://postspectacular.com/work/nokia/friends/start

class Blob
  include Processing::Proxy
  # A list to keep track of all the points in our blob
  attr_reader :skeleton, :body_radius, :radius, :total_points
  # We should modify this constructor to receive arguments
  # So that we can make many different types of blobs
  
  def initialize
    # Create the empty 
    @skeleton = []
    # Let's make a volume of joints!
    cvjd = ConstantVolumeJointDef.new
    # Where and how big is the blob
    center = Vec2.new(width / 2, height / 2)
    @radius = 100
    @total_points = 20
    @body_radius = 12
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
      cs.m_radius = box2d.scale_to_world(body_radius)
      # Define a fixture
      fd = FixtureDef.new
      fd.shape = cs
      # For filtering out collisions
      #fd.filter.groupIndex = -2
      # Parameters that affect physics
      fd.density = 1
      # Finalize the body
      body.create_fixture(fd)
      # Add it to the volume
      cvjd.add_body(body)
      # Store our own copy for later rendering
      skeleton << body
   end
    # These parameters control how stiff vs. jiggly the blob is
    cvjd.frequencyHz = 10.0
    cvjd.dampingRatio = 1.0
    # Put the joint thing in our world!
    box2d.world.create_joint(cvjd)
 end
 
  # Time to draw the blob!
  # Can you make it a cute character, a la 
  # http://postspectacular.com/work/nokia/friends/start
  def display
    # Draw the outline
    begin_shape
    no_fill
    stroke(0)
    stroke_weight(1)
    skeleton.each do |b|
      pos = box2d.body_coord(b)
      vertex(pos.x, pos.y)
    end
    end_shape(CLOSE)
    # Draw the individual circles
    skeleton.each do |b|
      # We look at each body and get its screen position
      pos = box2d.body_coord(b)
      # Get its angle of rotation
      a = b.get_angle
      push_matrix
      translate(pos.x, pos.y)
      rotate(a)
      fill(175)
      stroke(0)
      stroke_weight(1)
      ellipse(0, 0, body_radius * 2, body_radius * 2)
      pop_matrix
   end
 end
end
