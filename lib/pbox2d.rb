working_directory = File.join(File.dirname(__FILE__))
$LOAD_PATH << working_directory unless $LOAD_PATH.include?(working_directory)
Dir[File.join(working_directory, '*.jar')].each do |jar|
  require jar
end

module PB
  include_package 'org.jbox2d.collision.shapes'
  include_package 'org.jbox2d.common'
  include_package 'org.jbox2d.dynamics'
  include_package 'processing.box2d'
end

ContactListener = Java::OrgJbox2dCallbacks::ContactListener
Box2D = PB::Box2DProcessing
