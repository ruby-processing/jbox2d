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

  def step_options(args = {})
    default_step.merge(args)
    set_step(args[:time_step], args[:velocity_iter], args[:position_iter])
  end

  def defaults
    { scale: 10.0, gravity: [0, -10], warm: true, continuous: true }
  end

  def default_step
    { time_step: 1.0 / 60, velocity_iter: 8, position_iter: 10 }
  end

  def gravity(args)
    change_gravity(args.to_java(Java::float))
  end

  def add_listener(listener)
    # in combination with field accessor we can access protected world
    world.setContactListener(listener)
  end

  def version
    format('pbox2d version %s', Pbox2d::VERSION)
  end
end
