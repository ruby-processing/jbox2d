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
public class Box2DProcessing {

    private PApplet parent;

    private float height;

    /**
     * The Box2D world
     */
    private World world;

    // Variables to keep track of translating between world and screen coordinates
    /**
     *
     */
    private float transX;// = 320.0f;

    /**
     *
     */
    private float transY;// = 240.0f;

    /**
     *
     */
    private float scaleFactor;// = 10.0f;

    /**
     * 
     */
    private float yFlip;// = -1.0f; //flip y coordinate

    /**
     * Controls access to processing draw loop
     */
    private boolean isActive = false;

    private Body groundBody;

    /**
     * Construct with a default scaleFactor of 10
     * @param p
     */
    public Box2DProcessing(PApplet p) {
        this(p, 10);
    }

    /**
     *
     * @param p
     * @param sf
     */
    public Box2DProcessing(PApplet p, float sf) {
        parent = p;
        height = p.height;
        transX = parent.width / 2;
        transY = parent.height / 2;
        scaleFactor = sf;
        yFlip = -1;
        setActive(true);
    }
 
    /**
     * Change the scaleFactor
     * @param scale
     */
    public void scaleFactor(float scale) {
        scaleFactor = scale;
    }

    // 
    /**
     * This is the all important physics "step" function
     * Says to move ahead one unit in time
     * Default
     */
    public void step() {
        float timeStep = 1.0f / 60f;
        this.step(timeStep, 10, 8);
        world.clearForces();
    }

    /**
     * Custom
     * @param timeStep
     * @param velocityIterations
     * @param positionIterations
     */
    public void step(float timeStep, int velocityIterations, int positionIterations) {
        world.step(timeStep, velocityIterations, positionIterations);
    }

    /**
     *
     * @param b
     */
    public void warmStarting(boolean b) {
        world.setWarmStarting(b);
    }

    /**
     *
     * @param b
     */
    public void continuousPhysics(boolean b) {
        world.setContinuousPhysics(b);
    }

    /**
     * Create a default world with default gravity
     */
    public void createWorld() {
        Vec2 gravity = new Vec2(0.0f, -10.0f);
        createWorld(gravity);
        warmStarting(true);
        continuousPhysics(true);
    }

    /**
     *
     * @param gravity
     */
    public void createWorld(Vec2 gravity) {
        createWorld(gravity, true, true);
    }

    /**
     *
     * @param gravity
     * @param warmStarting
     * @param continous
     */
    public void createWorld(Vec2 gravity, boolean warmStarting, boolean continous) {
        world = new World(gravity);
        warmStarting(warmStarting);
        continuousPhysics(continous);
        BodyDef bodyDef = new BodyDef();
        groundBody = world.createBody(bodyDef);
    }

    /**
     *
     * @return
     */
    public Body groundBody() {
        return groundBody;
    }
 
    /**
     * Set the gravity (this can change in real-time)
     * @param x
     * @param y
     */
    public void gravity(float x, float y) {
        world.setGravity(new Vec2(x, y));
    }

 
    /**
     * Box2d has its own coordinate system and we have to move back and forth 
     * between them to convert from Box2d world to processing pixel space
     * @param world
     * @return
     */
    public Vec2 worldToProcessing(Vec2 world) {
        return worldToProcessing(world.x, world.y);
    }

    /**
     * Box2d has its own coordinate system and we have to move back and forth 
     * between them to convert from Box2d world to processing pixel space
     * @param worldX
     * @param worldY
     * @return
     */
    public Vec2 worldToProcessing(float worldX, float worldY) {
        float pixelX = map(worldX, 0f, 1f, transX, transX + scaleFactor);
        float pixelY = map(worldY, 0f, 1f, transY, transY + scaleFactor);
        if (yFlip == -1.0f) {
            pixelY = map(pixelY, 0f, height, height, 0f);
        }
        return new Vec2(pixelX, pixelY);
    }

    /**
     * convert Coordinate from pixel space to box2d world
     * @param screen
     * @return
     */
    public Vec2 processingToWorld(Vec2 screen) {
        return processingToWorld(screen.x, screen.y);
    }

    /**
     *
     * @param pixelX
     * @param pixelY
     * @return
     */
    public Vec2 processingToWorld(float pixelX, float pixelY) {
        float worldX = map(pixelX, transX, transX + scaleFactor, 0f, 1f);
        float worldY = pixelY;
        if (yFlip == -1.0f) {
            worldY = map(pixelY, height, 0f, 0f, height);
        }
        worldY = map(worldY, transY, transY + scaleFactor, 0f, 1f);
        return new Vec2(worldX, worldY);
    }

    /**
     * Scale from processing to world 
     * @param val
     * @return
     */
    public float scaleToWorld(float val) {
        return val / scaleFactor;
    }

    /**
     * Scale from world to processing
     * @param val
     * @return
     */
    public float scaleToProcessing(float val) {
        return val * scaleFactor;
    }


    /**
     * Vector scale between two worlds
     * @param v
     * @return
     */
    public Vec2 vectorToWorld(Vec2 v) {
        Vec2 u = new Vec2(v.x / scaleFactor, v.y / scaleFactor);
        u.y *= yFlip;
        return u;
    }

    /**
     * Translate from world coords to processing as a Vec2
     * @param x
     * @param y
     * @return
     */
    public Vec2 vectorToWorld(float x, float y) {
        Vec2 u = new Vec2(x / scaleFactor, y / scaleFactor);
        u.y *= yFlip;
        return u;
    }

    /**
     * Translate from world to processing as a Vec2
     * @param v
     * @return
     */
    public Vec2 vectorToProcessing(Vec2 v) {
        Vec2 u = new Vec2(v.x * scaleFactor, v.y * scaleFactor);
        u.y *= yFlip;
        return u;
    }

    /**
     * A common task we have to do a lot
     * @param bd
     * @return
     */
    public Body createBody(BodyDef bd) {
        return world.createBody(bd);
    }

    /**
     * A common task we have to do a lot
     * @param jd
     * @return
     */
    public Joint createJoint(JointDef jd) {
        return world.createJoint(jd);
    }

    /**
     *
     * @param b
     * @return body coord as Vec2
     */
    public Vec2 bodyCoord(Body b) {
        Transform xf = b.getTransform();//b.getXForm();
        //return coordWorldToPixels(xf.position); 
        return worldToProcessing(xf.p);
    }

    /**
     *
     * @param b
     */
    public void destroyBody(Body b) {
        world.destroyBody(b);
    }

    /**
     * Access the processing draw loop by java reflection
     */
    public void draw() {
        step();
    }

    /**
     * Recommended inclusion in a processing library
     */
    public void dispose() {
        setActive(false);
    }

    public float height(){
        return height; 
    }
    
      private float map(float val, float startIn, float endIn, float startOut, float endOut){
        return startOut + (endOut - startOut) * ((val - startIn) / (endIn - startIn));
    }

    private void setActive(boolean active) {
        if (active != isActive) {
            isActive = active;
            if (active) {
                parent.registerMethod("dispose", this);
                parent.registerMethod("draw", this);
            } else {
                parent.unregisterMethod("draw", this);
            }
        }
    }
}
