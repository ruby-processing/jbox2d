### Using JBox2D in ruby-processing

Here we demonstrate how to use JBox2D library as a rubygem. This approach could be an exemplar of how to use other processing/java libraries with both ruby-processing and JRubyArt (now using a maven build).
![liquidy](http://4.bp.blogspot.com/-dwnDQZVugwo/VFXrDxGOy4I/AAAAAAAAEgo/irsZxW_WLOA/s400/liquidy.png)

![Travis CI](https://travis-ci.org/ruby-processing/jbox2d.svg)
[![Gem Version](https://badge.fury.io/rb/pbox2d.svg)](http://badge.fury.io/rb/pbox2d)

CI Build can only pass when processing version is available from maven central.

### Web Links

[JBox2D Home][]

[JBox2D on github][]

[Box2D for processing on github][]

Downloads including examples [zip][]
[Wiki][]

### Licensing

Daniel Murphy is currently claiming ownership of jbox2d (although surely a derived work):-

Copyright (c) 2014 Daniel Murphy

Dan Shiffman wrote the original PBox2D for processing (on which this implementation is based)

Copyright (c) 2014 Daniel Shiffman

This gem was created by Martin Prout

Copyright (c) 2015/19 Martin Prout

### To compile

To compile the gem follow the instructions for [JRubyArt][], but also available as a ruby gem:-
```bash
jruby -S gem install box2d
```
Like really easy, but if you have to use rvm or rbenv you will also know what to do (but then you might find this all a bit difficult to understand, and wonder where the tests are, believe me you should throw away those crutches).

### To use

You need to `require 'pbox2d'` in the the usual way (to require a gem). Now you should create a new instance of Box2D. However as in this included [example][] you may also need to `include ContactListener` interface (by [jruby magic][], including the interface as a module implements the java interface) if you wish to create your own jbox2d listener.
```ruby
# Since version 0.6.0, use the WorldBuilder factory module (avoids boiler-plate code)
# Only app is required there, default gravity is [0, -10], defaults to warm start
@box2d = WorldBuilder.build(app: self, gravity: [0, -20])
```
That's about all you need to know, to use the box2d instance to access the jbox2d physics world. Since version 0.6.0 runtime options `scale`, `gravity`, `warm_start`, and `continous_physics` options can be set using the keyword args see above (if unset sensible defaults are used). The `step_options` are set in the same way, but default options are often suitable. NB: You do not need to call `box2d.step` in the draw loop, to update the physics world, because we do that for you under the hood (using java reflection arghhh.....).
The other thing you should know is there is a mismatch between the physics world and the sketch world (processing got it wrong to my view, down is up), further the scaling is different. This is why you need to keep translating from one worlds (coordinates system) to the others coordinates (system), Dan Shiffman explains it in his [Nature of Code book][], Chapter 5 physics libraries, not that I've read it, I prefer to read code or [Sandi Metz][]. The really brave or adventurous should probably get [this book].

[JBox2D Home]:http://www.jbox2d.org/
[JBox2D on github]:https://github.com/jbox2d/jbox2d
[Box2D for processing on github]:https://github.com/shiffman/Box2D-for-Processing
[JRubyArt]:https://github.com/ruby-processing/JRubyArt
[example]:https://github.com/ruby-processing/jbox2d/blob/master/examples/test_contact/lib/custom_listener.rb
[jruby magic]:https://github.com/jruby/jruby/wiki/CallingJavaFromJRuby
[Nature of Code book]:http://natureofcode.com/
[Sandi Metz]:http://www.poodr.com/
[this book]:http://www.crcpress.com/product/isbn/9781466565760
[zip]:https://github.com/ruby-processing/jbox2d/archive/master.zip
[Wiki]:https://github.com/ruby-processing/jbox2d/wiki
