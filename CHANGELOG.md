### v0.6.0

Added import for jbox2d Particle, ParticleGroup etc.  Introduced WorldBuilder module to get rid of boilerplate code for the user. Reworked examples to use a common Boundary class.

### v0.5.0

Break compatability with ruby-processing. New build uses maven. Works with JRuby-9.0.3.0, processing-3.0.1 and jdk8.


### v0.4.2

Re-factor extension class, last release for ruby-processing (processing-2.2.1) getting read for JRubyArt version.

### v0.4.1

Favour explicit import of classes to package include.  Use forwardable in examples to make usable in both JRubyArt and ruby-processing, further to demonstrate alternative to including Processing::Proxy to get 'inner class' like access to processing methods, in own classes.

### v0.3.1

Need to be less specific about ruby-processing version

### v0.3.0 (was v0.2.1 but bumped version because it features new functionality)

Finally got ContactListener to work (currently best plan is to create your own CustomListener, see example test_contact)

### v0.2.0

Moving away from Shiffman Box2D design, to create a more ruby like interface added Step and Option classes to make it easier to initialize runtime and step options. On the ruby side options may/should be set with hash input. Gravity may still be set dynamically, but unless it is going to change it should be set via `init_options`. Unless `init_options` or `step_options` are set, defaults on java side are used.

### v0.1.1

Make common classes avaiable directly, expose sketch eight.

### v0.1.0

Now require 'pbox2d' matches gem name, refactor java methods by removing unnecessary get/set/pixel. Also prefer to world and to processing. Adjust examples, bump version to denote significant change.


### v0.0.1

First release, works but require name 'box2d' doesn't match gem name it is confusing
