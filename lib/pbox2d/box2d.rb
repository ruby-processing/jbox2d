require_relative  'version'

class Box2D < Java::ProcessingBox2d::Box2DProcessing
  field_accessor :world # allow access to protected variable

  def init_options(args = {})
    scale = args[:scale] || 10.0
    gravity = args[:gravity] || [0, -10.0]
    warm = args[:warm] || true
    continuous = args[:continuous] || true
    set_options(scale, gravity.to_java(Java::float), warm, continuous)   
  end

  def step_options(args = {})
    time_step = args[:time_step] || 1.0 / 60
    velocity = args[:velocity_iter] || 8
    position = args[:position_iter] || 10
    set_step(time_step, velocity, position)
  end

  def gravity(args)
    change_gravity(args.to_java(Java::float))
  end

  def add_listener(listener)
    # in combination with field accessor we can access protected world
    self.world.setContactListener(listener)
  end 

  def version
    format("pbox2d version %s", Pbox2D::VERSION)
  end
end
