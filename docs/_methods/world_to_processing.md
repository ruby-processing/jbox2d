---
layout: post
title:  "world_to_processing"
date:   2016-05-23 05:04:00
categories: jruby_art update
permalink: /methods/world_to_processing/
---
From physics world to sketch

Because of the peculiar choice by the processing guys down is up (dimensions in pixels) jbox2d doesn't like to live in the pixel world (where up is really up), and prefers meters or feet and inches (whatever). What this means is that there is a need to scale between the two worlds using world_to_processing and [processing_to_world][processing_to_world] methods provided. You should also study the included [example sketches][examples].

The java code ([PBox2D][pbox2d] inherits this from [Box2DProcessing][pbox2d])
### public Vec2 worldToProcessing(float worldX, float worldY) ###

```java
public Vec2 worldToProcessing(float worldX, float worldY) {
        float pixelX = map(worldX, 0f, 1f, parent.width / 2, parent.width / 2 + scaleFactor);
        float pixelY = map(worldY, 1f, 0f, parent.height / 2, parent.height / 2 + scaleFactor);
        return new Vec2(pixelX, pixelY);
}
```

### Ruby usage ###
Use camel case

```ruby
world_to_processing(x, y) # returns new Vec2 instance (in processing world)
```

[pbox2d]:{{ site.github.url }}/classes/pbox2d/
[processing_to_world]:{{ site.github.url }}/methods/processing_to_world/
[examples]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/external_library/gem/pbox2d/
