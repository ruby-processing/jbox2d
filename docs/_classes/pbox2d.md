---
layout: page
title: "PBox2D"
permalink: /classes/pbox2d/
---

The PBox2D class is a simple wrapper to help integrate the JBox2D world with ruby implementations of processing (_JRubyArt, PiCrate and propane_). Use the [WorldBuilder][world_builder] in your sketch setup to create an instance of this class.

```ruby
# Ruby version of java wrapper allows us to have more
# rubified interface, also needed for add_listener
class Box2D < Java::ProcessingBox2d::Box2DProcessing
  field_accessor :world # allow access to protected variable

  def init_options(args = {})
    args = defaults.merge(args)
    set_options(args[:scale],
                args[:gravity].to_java(Java::float),
                args[:warm],
                args[:continuous]
               )
  end

  def step_options(args = {})
    default_step.merge(args)
    set_step(args[:time_step], args[:velocity_iter], args[:position_iter])
  end

  def defaults
    { scale: 10.0, gravity: [0, -10], warm: true, continuous: true }
  end

  def default_step
    { time_step: 1.0 / 60, velocity_iter: 8, position_iter: 10 }
  end

  def gravity(args)
    change_gravity(args.to_java(Java::float))
  end

  def add_listener(listener)
    # in combination with field accessor we can access protected world
    world.setContactListener(listener)
  end

  def version
    format('pbox2d version %s', Pbox2d::VERSION)
  end
end
```

The java class
```java

package processing.box2d;

import org.jbox2d.common.Transform;
import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.World;
import org.jbox2d.dynamics.joints.Joint;
import org.jbox2d.dynamics.joints.JointDef;

import processing.core.PApplet;

/**
 * Loosely based on Box2D-for-processing by Dan Shiffman
 *
 * @author Martin Prout
 */
public abstract class Box2DProcessing {

    private final PApplet parent;
    private Options options;
    private Step stepO;
    private final float height;
    private final float width;
    /**
     * The Box2D world (we might need public access for our ContactListener)
     */
    protected World world;

    /**
     * Scale between processing sketch and physics world
     */
    private float scaleFactor;// = 10.0f;

    /**
     * Adjust for processing.org unfathomable choice of y-axis direction
     */
    private final int yFlip;// = -1; //flip y coordinate

    /**
     * Controls access to processing pre loop (via reflection)
     */
    private boolean isActive = false;

    private Body groundBody;

    /**
     *
     * @param p PApplet
     */
    public Box2DProcessing(PApplet p) {
        parent = p;
        height = p.height;
        width = p.width;
        yFlip = -1;
        setActive(true);
    }

    /**
     * Abstract method implement on ruby side
     *
     * @param listener Custom Listener, Sketch?
     */
    public abstract void addListener(org.jbox2d.callbacks.ContactListener listener);

    /**
     *
     * @param scale float
     * @param gravity float[]
     * @param warmStart boolean
     * @param continuous boolean
     */
    protected void setOptions(float scale, float[] gravity, boolean warmStart, boolean continuous) {
        options = new Options(scale, gravity, warmStart, continuous);
    }

    /**
     *
     * @param timeStep float
     * @param velocity int
     * @param position int
     */
    protected void setStep(float timeStep, int velocity, int position) {
        stepO = new Step(timeStep, velocity, position);
    }

    /**
     * This is the all important physics "step" function Says to move ahead one
     * unit in time Default
     */
    protected void step() {
        if (stepO == null) {
            stepO = new Step();
        }
        world.step(stepO.timeStep, stepO.velIters, stepO.posIters);
        world.clearForces();
    }

    /**
     * Create a world
     */
    public void createWorld() {
        if (options == null) {
            options = new Options();
        }
        Vec2 gravity = new Vec2(options.gravity[0], options.gravity[1]);
        scaleFactor = options.scaleFactor;
        world = new World(gravity);
        world.setWarmStarting(options.warm);
        world.setContinuousPhysics(options.continuous);
        BodyDef bodyDef = new BodyDef();
        groundBody = world.createBody(bodyDef);
    }

    /**
     *
     * @return Body
     */
    public Body groundBody() {
        return groundBody;
    }

    /**
     * Set the gravity (this can change in real-time)
     *
     * @param gravity float[]
     */
    protected void changeGravity(float[] gravity) {
        world.setGravity(new Vec2(gravity[0], gravity[1]));
    }

    /**
     * Box2d has its own coordinate system and we have to move back and forth
     * between them to convert from Box2d world to processing pixel space
     *
     * @param world Vec2
     * @return Vec2
     */
    public Vec2 worldToProcessing(Vec2 world) {
        return worldToProcessing(world.x, world.y);
    }

    /**
     * Box2d has its own coordinate system and we have to move back and forth
     * between them to convert from Box2d world to processing pixel space
     * Note reverse Y mapping (processing poxy coord system again)
     * @param worldX float
     * @param worldY float
     * @return Vec2
     */
    public Vec2 worldToProcessing(float worldX, float worldY) {
        float pixelX = map(worldX, 0f, 1f, parent.width / 2, parent.width / 2 + scaleFactor);
        float pixelY = map(worldY, 1f, 0f, parent.height / 2, parent.height / 2 + scaleFactor);
        return new Vec2(pixelX, pixelY);
    }

    /**
     * convert Coordinate from pixel space to box2d world
     *
     * @param screen Vec2
     * @return Vec2
     */
    public Vec2 processingToWorld(Vec2 screen) {
        return processingToWorld(screen.x, screen.y);
    }

    /**
     * Note reverse Y mapping (processing poxy coord system again)
     * @param pixelX float
     * @param pixelY float
     * @return Vec2
     */
    public Vec2 processingToWorld(float pixelX, float pixelY) {
        float worldX = map(pixelX, parent.width / 2, parent.width / 2 + scaleFactor, 0f, 1f);
        float worldY = map(pixelY, parent.height / 2, parent.height / 2 + scaleFactor, 1f, 0f);
        return new Vec2(worldX, worldY);
    }

    /**
     * Scale from processing to world
     *
     * @param val float
     * @return float
     */
    public float scaleToWorld(float val) {
        return val / scaleFactor;
    }

    /**
     * Scale from world to processing
     *
     * @param val float
     * @return float
     */
    public float scaleToProcessing(float val) {
        return val * scaleFactor;
    }

    /**
     * Vector scale between two worlds
     *
     * @param v Vec2
     * @return Vec2
     */
    public Vec2 vectorToWorld(Vec2 v) {
        Vec2 u = new Vec2(v.x / scaleFactor, v.y / scaleFactor);
        u.y *= yFlip;
        return u;
    }

    /**
     * Translate from world coords to processing as a Vec2
     *
     * @param x float
     * @param y float
     * @return Vec
     */
    public Vec2 vectorToWorld(float x, float y) {
        Vec2 u = new Vec2(x / scaleFactor, y / scaleFactor);
        u.y *= yFlip;
        return u;
    }

    /**
     * Translate from world to processing as a Vec2
     *
     * @param v Vec
     * @return Vec
     */
    public Vec2 vectorToProcessing(Vec2 v) {
        Vec2 u = new Vec2(v.x * scaleFactor, v.y * scaleFactor);
        u.y *= yFlip;
        return u;
    }

    /**
     * A common task we have to do a lot
     *
     * @param bd BodyDef
     * @return Body
     */
    public Body createBody(BodyDef bd) {
        return world.createBody(bd);
    }

    /**
     * A common task we have to do a lot
     *
     * @param jd JointDef
     * @return World
     */
    public Joint createJoint(JointDef jd) {
        return world.createJoint(jd);
    }

    /**
     *
     * @param b Body
     * @return body coord as Vec2
     */
    public Vec2 bodyCoord(Body b) {
        Transform xf = b.getTransform();
        return worldToProcessing(xf.p);
    }

    /**
     *
     * @param b Body
     */
    public void destroyBody(Body b) {
        world.destroyBody(b);
    }

    /**
     * Access the processing pre loop by java reflection
     */
    public void pre() {
        step();
    }

    /**
     * Recommended inclusion in a processing library
     */
    public void dispose() {
        setActive(false);
    }

    /**
     *
     * @return height float
     */
    public float height() {
        return height;
    }

    /**
     *
     * @return width float
     */
    public float width() {
        return width;
    }

    private float map(float val, float startIn, float endIn, float startOut, float endOut) {
        return startOut + (endOut - startOut) * ((val - startIn) / (endIn - startIn));
    }

    private void setActive(boolean active) {
        if (active != isActive) {
            isActive = active;
            if (active) {
                parent.registerMethod("dispose", this);
                parent.registerMethod("pre", this);
            } else {
                parent.unregisterMethod("pre", this);
            }
        }
    }
}

```
