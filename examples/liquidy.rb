require 'pbox2d'
require_relative 'lib/particle_system'
attr_reader :box2d, :boundaries, :systems

def setup
  size(400, 300)
  @box2d = Box2D.new(self)
  box2d.init_options(gravity: [0, -20])
  box2d.create_world
  # to set a custom gravity otherwise
  # box2d.gravity([0, -20])
  # Create Arrays
  @systems = []
  @boundaries = [
    Boundary.new(self, 50, 100, 5, -0.3),
    Boundary.new(self, 250, 175, 5, 0.5)
  ]
end

def draw
  background(255)
  # Display all the boundaries
  boundaries.each(&:display)
  # Run all the particle systems
  return unless systems.size > 0
  systems.each do |system|
    system.run
    # refresh particles (else we'll run out)
    system.add_particles(self, rand(0..2))
  end
end

def mouse_pressed
  # Add a new Particle System whenever the mouse is clicked
  systems << ParticleSystem.new(self, 0, mouse_x, mouse_y)
end
