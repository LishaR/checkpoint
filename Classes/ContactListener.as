package {
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Dynamics.Joints.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
	
    class ContactListener extends b2ContactListener {
        override public function BeginContact(contact:b2Contact):void {
            // getting the fixtures that collided
            var fixtureA:b2Fixture=contact.GetFixtureA();
            var fixtureB:b2Fixture=contact.GetFixtureB();
			
            if (fixtureA.GetBody().GetUserData() != null) {
				trace(fixtureA.GetBody().GetUserData().getEntityType());
				if (fixtureA.GetBody().GetUserData().getEntityType() == "player") {
					trace("touch");
				}
            }
        }
    }
}