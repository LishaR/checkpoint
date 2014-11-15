package {
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Dynamics.Joints.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
	
    class ContactListener extends b2ContactListener {
		public var checkpointBody:b2Body;
		
		public function ContactListener(newCheckpointBody:b2Body) {
			checkpointBody = newCheckpointBody;
		}
		
        override public function BeginContact(contact:b2Contact):void {
            // getting the fixtures that collided
            var fixtureA:b2Fixture=contact.GetFixtureA();
            var fixtureB:b2Fixture=contact.GetFixtureB();
			
            if (fixtureA.GetBody().GetUserData() && fixtureB.GetBody().GetUserData()) {
				if (fixtureA.GetBody().GetUserData().getEntityType() == "player") {
					var playerBody:b2Body = fixtureA.GetBody();
					
					if (fixtureB.GetBody().GetUserData().getEntityType() == "platform") {
						playerBody.GetUserData().setCanJump(true);
					}
					
					if (fixtureB.GetBody().GetUserData().getEntityType() == "lava") {
						playerBody.SetPosition(checkpointBody.GetPosition());
					}
				}
            }
        }
    }
}