/**
 * Reduce typing by using ContactAdaptor rather than ContactListener
 * @author Martin Prout
 */
package org.jbox2d.callbacks;

import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

public abstract class ContactAdaptor implements ContactListener {

    @Override
    public void beginContact(Contact cntct) {
    }

    @Override
    public void endContact(Contact cntct) {
    }

    @Override
    public void preSolve(Contact cntct, Manifold mnfld) {
    }

    @Override
    public void postSolve(Contact cntct, ContactImpulse ci) {
    }
}
