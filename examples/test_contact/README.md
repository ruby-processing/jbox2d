### Custom ContactListener example

This example is somewhat based on the CollisionListening example [Box2D for processing][] by Dan Shiffman, but with a CustomContact listener.  It use the jruby way of implementing an interface (which is to include as if it were a module). Note the use off the more elegant ruby way to discriminate between Boundary (has no :change method) and particle (responds_to? :change method)

[Box2D for processing]:https://github.com/shiffman/Box2D-for-Processing

