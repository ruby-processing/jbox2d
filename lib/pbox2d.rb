working_directory = File.join(File.dirname(__FILE__))
$LOAD_PATH << working_directory unless $LOAD_PATH.include?(working_directory)
Dir[File.join(working_directory, '*.jar')].each do |jar|
  require jar
end

# These modules allows package access to the wrapped java packages
module PB
  include_package 'org.jbox2d.collision.shapes'
  include_package 'org.jbox2d.common'
  include_package 'processing.box2d'
end

module Dynamics
  include_package 'org.jbox2d.dynamics'
  include_package 'org.jbox2d.dynamics.contacts'
  include_package 'org.jbox2d.dynamics.joints'
end

ContactListener = Java::OrgJbox2dCallbacks::ContactListener
Transform = PB::Transform
Vec2 = PB::Vec2
PolygonShape = PB::PolygonShape
CircleShape = PB::CircleShape
ChainShape = PB::ChainShape
Body = Dynamics::Body
BodyDef = Dynamics::BodyDef
BodyType = Dynamics::BodyType
World = Dynamics::World
Joint = Dynamics::Joint
JointDef = Dynamics::JointDef
DistanceJointDef = Dynamics::DistanceJointDef
RevoluteJoint = Dynamics::RevoluteJoint
RevoluteJointDef = Dynamics::RevoluteJointDef
FixtureDef = Dynamics::FixtureDef

require_relative 'pbox2d/box2d.rb'
