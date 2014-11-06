require_relative  'version'

class Box2D < Java::ProcessingBox2d::Box2DProcessing

  def version
    format("pbox2d version %s", Pbox2D::VERSION)
  end
end
