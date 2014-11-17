require_relative 'version'
# Ruby version of java wrapper allows us to have more
# rubified interface, also needed for add_listener
class Box2D < Java::ProcessingBox2d::Box2DProcessing
  field_accessor :world # allow access to protected variable

  def init_options(args = {})
    args = defaults.merge(args)
    set_options(args[:scale],
                args[:gravity].to_java(Java::float),
                args[:warm],
                args[:continuous]
               )
  end

  def defaults
    { scale: 10.0, gravity: [0, -10], warm: true, continuous: true }
  end

  def step_options(args = {})
    time_step = args.fetch(:time_step, 1.0 / 60)
    velocity = args.fetch(:velocity_iter, 8)
    position = args.fetch(:position_iter, 10)
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
    format('pbox2d version %s', Pbox2D::VERSION)
  end
end
