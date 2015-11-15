# A Box class, note how to access class ParticleGroupDef in jruby
# which is currently not on an included path for pbox2d
class Box
  def initialize(b2d, x, y)
    w = rand(1..3)
    h = rand(1..3)
    shape = PolygonShape.new
    pos = b2d.processing_to_world(x, y)
    shape.setAsBox(w, h, pos, 0)
    pd = ParticleGroupDef.new
    pd.shape = shape
    b2d.world.create_particle_group(pd)
  end
end
