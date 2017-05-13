---
layout: post
title:  "processing_to_world"
permalink: /methods/processing_to_world/
---
From sketch to physics world and vice versa

Because of the peculiar choice by the processing guys down is up (dimensions in pixels) jbox2d doesn't like to live in the pixel world (where up is really up), and prefers meters or feet and inches (whatever). What this means is that there is a need to scale between the two worlds using [world_to_processing][world_to_processing] and processing_to_world methods provided. You should study the included example sketches.


The java code ([PBox2D][pbox2d] inherits this from [Box2DProcessing][pbox2d])
### public Vec2 processingToWorld(float worldX, float worldY) ###

```java
public Vec2 processingToWorld(float pixelX, float pixelY) {
      float worldX = map(pixelX, parent.width / 2, parent.width / 2 + scaleFactor, 0f, 1f);
      float worldY = map(pixelY, parent.height / 2, parent.height / 2 + scaleFactor, 1f, 0f);
      return new Vec2(worldX, worldY);
}
```

### Ruby usage ###
Use camel case

```ruby
processing_to_world(x, y) # returns new Vec2 instance (in the PBox2D world)
```

[pbox2d]:{{ site.github.url }}/classes/pbox2d/
[world_to_processing]:{{ site.github.url }}/methods/world_to_processing/
[examples]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/external_library/gem/pbox2d/
