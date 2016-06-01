working_directory = File.join(File.dirname(__FILE__))
$LOAD_PATH << working_directory unless $LOAD_PATH.include?(working_directory)
Dir[File.join(working_directory, '*.jar')].each do |jar|
  require jar
end

ContactListener = Java::OrgJbox2dCallbacks::ContactListener
ContactAdaptor = Java::OrgJbox2dCallbacks::ContactAdaptor

def import_class_list(list, string)
  list.each { |d| java_import format(string, d) }
end

common = %w( Vec2 Transform )
common_format = 'org.jbox2d.common.%s'
import_class_list(common, common_format)
shape = %w( PolygonShape CircleShape ChainShape Shape )
shape_format = 'org.jbox2d.collision.shapes.%s'
import_class_list(shape, shape_format)
world = %w( Body BodyDef BodyType World FixtureDef )
world_format = 'org.jbox2d.dynamics.%s'
import_class_list(world, world_format)
joint = %w(
  Joint
  JointDef
  DistanceJointDef
  RevoluteJoint
  RevoluteJointDef
  MouseJointDef
  ConstantVolumeJointDef
)
joint_format = 'org.jbox2d.dynamics.joints.%s'
import_class_list(joint, joint_format)

# Import into module namespace to avoid likely clashes
module PB
  particle = %w(
    ParticleColor
    ParticleContact
    ParticleGroupDef
    ParticleBodyContact
    ParticleGroup
    ParticleType
    ParticleGroupType
    ParticleGroupDef
    ParticleSystem
    StackQueue
    VoronoiDiagram
  )
  particle_format = 'org.jbox2d.particle.%s'
  import_class_list(particle, particle_format)
end

require_relative 'pbox2d/box2d.rb'

# Box2D factory
module WorldBuilder
  def self.build(app:, **opts)
    b2d = Box2D.new(app)
    b2d.init_options(opts)
    b2d.create_world
    b2d
  end
end
