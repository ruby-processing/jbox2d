package processing.box2d;

/**
 * 
 * @author Martin Prout
 */
public class Options {

    /**
     * Continuous physics
     */
    public final boolean continuous;

    /**
     * Warm start
     */
    public final boolean warm;

    /**
     * gravity as an array of float
     */
    public final float[] gravity;

    /**
     * Factor to scale between physics world and sketch
     */
    public final float scaleFactor;

    /**
     *
     * @param scaleFactor
     * @param gravity
     * @param warmStart
     * @param continuousPhysics
     */
    public Options(float scaleFactor, float[] gravity, boolean warmStart, boolean continuousPhysics) {
        this.scaleFactor = scaleFactor;
        this.gravity = gravity;
        this.warm = warmStart;
        this.continuous = continuousPhysics;        
    }

    /**
     * Default Options constructor
     */
    public Options() {
        this.scaleFactor = 10f;
        this.gravity = new float[]{0, -10f};
        this.warm = true;
        this.continuous = true;
    }
}
