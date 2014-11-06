working_directory = File.join(File.dirname(__FILE__))
$LOAD_PATH << working_directory unless $LOAD_PATH.include?(working_directory)
Dir[File.join(working_directory, '*.jar')].each do |jar|
  require jar
end

module PB
  include_package 'org.jbox2d.collision.shapes'
  include_package 'org.jbox2d.common'
  include_package 'org.jbox2d.dynamics'
  include_package 'org.jbox2d.dynamics.joints'
  include_package 'processing.box2d'
end

ContactListener = Java::OrgJbox2dCallbacks::ContactListener
Transform = PB::Transform                                                                                                                                      
Vec2 = PB::Vec2                                                       
Body = PB::Body                                                     
BodyDef = PB::BodyDef  
BodyType = PB::BodyType
World = PB::World                                                    
Joint = PB::Joint                                             
JointDef = PB::JointDef
FixtureDef = PB::FixtureDef
PolygonShape = PB::PolygonShape
CircleShape = PB::CircleShape
ChainShape = PB::ChainShape

require_relative 'pbox2d/box2d.rb'
