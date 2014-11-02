### Using JBox2D in ruby-processing

Here we demonstrate how to use JBox2D library as a rubygem. This approach could be an exemplar of how to use other processing/java libraries with ruby-processing  
![liquidy](http://4.bp.blogspot.com/-dwnDQZVugwo/VFXrDxGOy4I/AAAAAAAAEgo/irsZxW_WLOA/s400/liquidy.png)


### Web Links

[JBox2D Home][]

[JBox2D on github][]

[Box2D for processing on github][]

### Licensing

Daniel Murphy is currently claiming ownership of jbox2d (although surely a derived work):-

Copyright (c) 2014 Daniel Murphy

Dan Shiffman wrote the original PBox2D for processing (on which this implementation is based)

Copyright (c) 2014 Daniel Shiffman
 
This gem was created by Martin Prout

Copyright (c) 2014 Martin Prout

### To compile

To compile the gem follow the instructions for [JRubyArt][], but also available as a ruby gem:-
```bash
jruby -S gem install box2d
```
Like really easy, but if you have to use rvm or rbenv you will also know what to do (but then you might find this all a bit difficult to understand, and wonder where the tests are, believe me you should throw away those crutches).

### To use

You need to `require 'pbox2d'` in the the usual way (to require a gem) but as in the included [examples][] you must also `include ContactListener` interface (by [jruby magic], including the interface as a module implements the java interface). Now you should create a new instance of Box2D.
```ruby
@box2d = Box2D.new(self)
box2d.create_world 
box2d.set_gravity(0, -20) # to set a custom gravity
```
That's about all you need to know, use the box2d instance to access the jbox2d physics world. Ordinarily (with jbox2d) you need to set some other parameters, and call `box2d.step` in the draw loop, to update the physics world.
To make things dead simple, we have set those parameters to sensible defaults, and call `step` in the draw loop for you (under the hood using java reflection). The other thing you should know is there is a mismatch between the physics world and the sketch world (processing got it wrong to my view, down is up), further the scaling is different. This is why you need to keep translating from one worlds (coordinates) to the others coordinates, Dan Shiffman explains it in his [Nature of Code book][], Chapter 5 physics libraries, not that I've read it, I prefer to read code or [Sandi Metz][].

[JBox2D Home]:http://www.jbox2d.org/
[JBox2D on github]:https://github.com/jbox2d/jbox2d
[Box2D for processing on github]:https://github.com/shiffman/Box2D-for-Processing
[JRubyArt]:https://github.com/ruby-processing/JRubyArt
[examples]:https://github.com/ruby-processing/jbox2d/blob/master/examples/liquidy.rb
[jruby magic]:https://github.com/jruby/jruby/wiki/CallingJavaFromJRuby
[Nature of Code book]:http://natureofcode.com/
[Sandi Metz]:http://www.poodr.com/
