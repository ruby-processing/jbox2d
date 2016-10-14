---
layout: post
title:  "scale_to_processing"
permalink: /methods/scale_to_processing/
---
From sketch to physics world and vice versa

The java code ([PBox2D][pbox2d] inherits this from [Box2DProcessing][pbox2d])
### public float scaleToProcessing(float val) ###
{% highlight java %}
public float scaleToProcessing(float val) {
        return val * scaleFactor;
}
{% endhighlight %}

### Ruby usage ###
Use camel case
{% highlight ruby %}
scale_to_processing(val)
{% endhighlight %}

[pbox2d]:{{ site.github.url }}/classes/pbox2d/
[world_to_processing]:{{ site.github.url }}/methods/world_to_processing/
[examples]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/external_library/gem/pbox2d/
