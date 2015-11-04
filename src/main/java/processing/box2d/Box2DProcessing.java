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
    private final float yFlip;// = -1.0f; //flip y coordinate

    /**
     * Controls access to processing pre loop (via reflection)
     */
    private boolean isActive = false;

    private Body groundBody;

    /**
     *
     * @param p
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
     * @param scale
     * @param gravity
     * @param warmStart
     * @param continuous
     */
    protected void setOptions(float scale, float[] gravity, boolean warmStart, boolean continuous) {
        options = new Options(scale, gravity, warmStart, continuous);
    }

    /**
     *
     * @param timeStep
     * @param velocity
     * @param position
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
     * @return
     */
    public Body groundBody() {
        return groundBody;
    }

    /**
     * Set the gravity (this can change in real-time)
     *
     * @param gravity
     */
    protected void changeGravity(float[] gravity) {
        world.setGravity(new Vec2(gravity[0], gravity[1]));
    }

    /**
     * Box2d has its own coordinate system and we have to move back and forth
     * between them to convert from Box2d world to processing pixel space
     *
     * @param world
     * @return
     */
    public Vec2 worldToProcessing(Vec2 world) {
        return worldToProcessing(world.x, world.y);
    }

    /**
     * Box2d has its own coordinate system and we have to move back and forth
     * between them to convert from Box2d world to processing pixel space
     * Note reverse Y mapping (processing poxy coord system again)
     * @param worldX
     * @param worldY
     * @return
     */
    public Vec2 worldToProcessing(float worldX, float worldY) {
        float pixelX = map(worldX, 0f, 1f, parent.width / 2, parent.width / 2 + scaleFactor);
        float pixelY = map(worldY, 1f, 0f, parent.height / 2, parent.height / 2 + scaleFactor);
        return new Vec2(pixelX, pixelY);
    }

    /**
     * convert Coordinate from pixel space to box2d world
     *
     * @param screen
     * @return
     */
    public Vec2 processingToWorld(Vec2 screen) {
        return processingToWorld(screen.x, screen.y);
    }

    /**
     * Note reverse Y mapping (processing poxy coord system again)
     * @param pixelX
     * @param pixelY
     * @return
     */
    public Vec2 processingToWorld(float pixelX, float pixelY) {
        float worldX = map(pixelX, parent.width / 2, parent.width / 2 + scaleFactor, 0f, 1f);
        float worldY = map(pixelY, parent.height / 2, parent.height / 2 + scaleFactor, 1f, 0f);
        return new Vec2(worldX, worldY);
    }

    /**
     * Scale from processing to world
     *
     * @param val
     * @return
     */
    public float scaleToWorld(float val) {
        return val / scaleFactor;
    }

    /**
     * Scale from world to processing
     *
     * @param val
     * @return
     */
    public float scaleToProcessing(float val) {
        return val * scaleFactor;
    }

    /**
     * Vector scale between two worlds
     *
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
     *
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
     *
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
     *
     * @param bd
     * @return
     */
    public Body createBody(BodyDef bd) {
        return world.createBody(bd);
    }

    /**
     * A common task we have to do a lot
     *
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
        Transform xf = b.getTransform();
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
     * @return
     */
    public float height() {
        return height;
    }

    /**
     *
     * @return
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
