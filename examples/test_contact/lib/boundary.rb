CENTER ||= Java::ProcessingCore::PConstants::CENTER

class Boundary
  include PB
  attr_reader :box2d, :x, :y, :w, :h, :b
  def initialize(b2d, x, y, w, h)
    @box2d, @x, @y, @w, @h = b2d, x, y, w, h
    sd = PolygonShape.new
    box2dW = box2d.scale_to_world(w / 2)
    box2dH = box2d.scale_to_world(h / 2)
    # We're just a box
    sd.setAsBox(box2dW, box2dH);


    # Create the body
    bd = BodyDef.new 
    bd.type = BodyType::STATIC;
    bd.position.set(box2d.processing_to_world(x,y))
    @b = box2d.create_body(bd)
    
    # Attached the shape to the body using a Fixture
    b.create_fixture(sd, 1)
    b.setUserData(self)
  end

  # Draw the boundary, if it were at an angle we'd have to do something fancier
  def display(app) 
    app.fill(0)
    app.stroke(0)
    app.rectMode(CENTER)
    app.rect(x,y,w,h)
  end
end