---
layout: page
title: "World Builder"
permalink: /modules/world_builder/
---
The WorldBuilder module is a factory, that provides a flexible options signature, and hides the post intialization of Box2D. Note that `app:` is a required keyword.
```ruby
module WorldBuilder
  def self.build(app:, **opts)
    b2d = Box2D.new(app)
    b2d.init_options(opts)
    b2d.create_world
    b2d
  end
end
```

Usage:
Strictly the `gravity:` option is optional here, it is only used to demonstrate a valid argument. No acceleration in horizontal plane and negative (falling) acceleration in vertical plane.
```ruby
@box2d = WorldBuilder.build(app: self, gravity: [0, -20])
```

See [:init_options][init_options] and [:defaults][init_options] methods for a list of available options

[init_options]:{{ site.github.url }}/methods/init_options/
