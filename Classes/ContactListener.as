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
				var fixtureAType:String = fixtureA.GetBody().GetUserData().getEntityType();
				var fixtureBType:String = fixtureB.GetBody().GetUserData().getEntityType();
				
				if (fixtureAType == "player") {
					var playerBody:b2Body = fixtureA.GetBody();
					
					if (fixtureBType == "spike") {
						playerBody.GetUserData().setDead(true);
					} else if (fixtureBType == "movingPlatform") {
						var world:b2World = fixtureB.GetBody().GetWorld();
						world.DestroyBody(fixtureB.GetBody());
						trace("deleted body");
						//fixtureB.GetBody().SetLinearVelocity(new b2Vec2(0, 0));
					} else if (fixtureBType == "platform") {
						var normal:b2Vec2 = contact.GetManifold().m_localPlaneNormal;

						// Allow player to jump if landing on platform from above
						if (b2Math.Dot(normal, new b2Vec2(0,1)) > 0.9) {
							playerBody.GetUserData().setCanJump(true);
						}
						
					} else if (fixtureBType == "lava") {
						playerBody.GetUserData().setDead(true);
					} else if (fixtureBType == "goal") {
						playerBody.GetUserData().setInGoal(true);
					}
				} else if (fixtureAType == "checkpoint") {
					if (fixtureBType == "lava") {
						checkpointBody.GetUserData().setDead(true);
					}
				}
            }
        }
    }
}