package processing.box2d;

/**
 *
 * @author Martin Prout
 */
public class Step {

    /**
     * time of step typically set to once per draw loop
     */
    public float timeStep;

    /**
     * No of velocity iterations
     */
    public int velIters;

    /**
     * No of position iterations
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
     * Step constructor with defaults
     */
    public Step(){
    this.timeStep = 1.0f / 60; 
    this.velIters = 8; 
    this.posIters = 10;    
    } 
}
