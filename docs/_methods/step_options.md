---

layout: post
title:  "step_options"
permalink: /methods/step_options/
---
Need not be called directly especially when using [WorldBuilder][world_builder]

```ruby
def step_options(args = {})
  default_step.merge(args)
   # now call the java method
  set_step(args[:time_step], args[:velocity_iter], args[:position_iter])
end
```

The default options

```ruby
def default_step
  { time_step: 1.0 / 60, velocity_iter: 8, position_iter: 10 }
end
```

[world_builder]:{{ site.github.url }}/modules/world_builder/
