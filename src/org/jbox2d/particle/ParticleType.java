package org.jbox2d.particle;

/**
 * The particle type. Can be combined with | operator. Zero means liquid.
 * 
 * @author dmurph
 */
public class ParticleType {
  public static final int B2_WATER_PARTICLE = 0;
  /** removed after next step */
  public static final int B2_ZOMBIE_PARTICLE = 1 << 1;
  /** zero velocity */
  public static final int B2_WALL_PARTICLE = 1 << 2;
  /** with restitution from stretching */
  public static final int B2_SPRING_PARTICLE = 1 << 3;
  /** with restitution from deformation */
  public static final int B2_ELASTIC_PARTICLE = 1 << 4;
  /** with viscosity */
  public static final int B2_VISCOUS_PARTICLE = 1 << 5;
  /** without isotropic pressure */
  public static final int B2_POWDER_PARTICLE = 1 << 6;
  /** with surface tension */
  public static final int B2_TENSILE_PARTICLE = 1 << 7;
  /** mixing color between contacting particles */
  public static final int B2_COLOR_MIXING_PARTICLE = 1 << 8;
  /** call b2DestructionListener on destruction */
  public static final int B2_DESTRUCTION_PARTICLE = 1 << 9;
}
