---
layout: post
title:  "init_options"
permalink: /methods/init_options/
---

### init_options method ###
Need not called directly if using [WorldBuilder][world_builder]
{% highlight ruby %}
def init_options(args = {})
    args = defaults.merge(args)
    set_options(args[:scale],
                args[:gravity].to_java(Java::float),
                args[:warm],
                args[:continuous]
               )
end
{% endhighlight %}

### related default options ###
Provides defaults for init_options
{% highlight ruby %}
def defaults
   { scale: 10.0, gravity: [0, -10], warm: true, continuous: true }
end
{% endhighlight %}

[world_builder]:{{ site.github.url }}/modules/world_builder/
