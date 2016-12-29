---
layout: post
title:  "init_options"
permalink: /methods/init_options/
---

### init_options method ###
Need not called directly if using [WorldBuilder][world_builder]
```ruby
def init_options(args = {})
    args = defaults.merge(args)
    set_options(args[:scale],
                args[:gravity].to_java(Java::float),
                args[:warm],
                args[:continuous]
               )
end
```

### related default options ###
Provides defaults for init_options
```ruby
def defaults
   { scale: 10.0, gravity: [0, -10], warm: true, continuous: true }
end
```

[world_builder]:{{ site.github.url }}/modules/world_builder/
