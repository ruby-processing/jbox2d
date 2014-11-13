class CustomListener
  include ContactListener
  
  def begin_contact(cp)
    # Get both fixtures
    f1 = cp.getFixtureA
    f2 = cp.getFixtureB
    # Get both bodies
    b1 = f1.getBody
    b2 = f2.getBody
    # Get our objects that reference these bodies
    o1 = b1.getUserData
    o2 = b2.getUserData
    return unless (o1.respond_to?(:change) && o2.respond_to?(:change))
    o1.change
    o2.change
  end
  
  def end_contact(cp)
  end
  
  def pre_solve(cp, m)
  end
  
  def post_solve(cp, ci)
  end
  
end