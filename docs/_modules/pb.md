---
layout: page
title: "PB (namespace)"
permalink: /modules/world_builder/
---
```ruby
# Import into module namespace to avoid likely clashes
module PB
  particle = %w(
    ParticleColor
    ParticleContact
    ParticleGroupDef
    ParticleBodyContact
    ParticleGroup
    ParticleType
    ParticleGroupType
    ParticleGroupDef
    ParticleSystem
    StackQueue
    VoronoiDiagram
  )
  particle_format = 'org.jbox2d.particle.%s'
  import_class_list(particle, particle_format)
end
```
