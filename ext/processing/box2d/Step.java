package processing.box2d;

/**
 *
 * @author Martin Prout
 */
public class Step {

    /**
     *
     */
    public float timeStep;

    /**
     *
     */
    public int velIters;

    /**
     *
     */
    public int posIters;
    
    /**
     *
     * @param timeStep
     * @param velIterations
     * @param posIterations
     */
    public Step(float timeStep, int velIterations, int posIterations){
    this.timeStep = timeStep; 
    this.velIters = velIterations; 
    this.posIters = posIterations;    
    }  
    
    /**
     *
     */
    public Step(){
    this.timeStep = 1.0f / 60; 
    this.velIters = 8; 
    this.posIters = 10;    
    } 
}
