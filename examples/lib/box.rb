# A Box class, note how to access class ParticleGroupDef in jruby
# which is imported into PB module (not in global namespace)
class Box
  attr_accessor :pg
  def initialize(b2d, x, y)
    w = rand(1..3)
    h = rand(1..3)
    shape = PolygonShape.new
    pos = b2d.processing_to_world(x, y)
    shape.setAsBox(w, h, pos, 0)
    pd = PB::ParticleGroupDef.new
    pd.shape = shape
    @pg = b2d.world.create_particle_group(pd)
  end
end
