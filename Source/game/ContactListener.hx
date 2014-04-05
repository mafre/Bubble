package game;

import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2ContactListener;

import game.emitter.EmitterType;
import game.entity.projectile.Bubble;
import game.entity.enemies.Enemy;
import game.entity.Entity;

class ContactListener extends B2ContactListener {

    public function new()
    {
        super();
    }

    public override function beginContact(contact:B2Contact):Void
    {
        var b1:Entity = contact.getFixtureA().getBody().getUserData();
        var b2:Entity = contact.getFixtureB().getBody().getUserData();

        if(b1.type == b2.type)
        {
            return;   
        }

        b1.handleCollision(b2);
        b2.handleCollision(b1);
    }
}