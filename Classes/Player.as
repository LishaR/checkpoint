package  {
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
	
	public class Player extends Entity {
		private static const PLAYER_RESTIT:Number = 0.01; // player bounciness on a 0 to 1 scale
		private static const PLAYER_FRICTION:Number = 0.3; // player friction
		private static const WORLD_SCALE:Number = 20; // pixels per meter
		
		private var playerBody:b2Body;
		
		private var checkpointHeld:Boolean;
		private var canJump:Boolean;

		public function Player(world:b2World, obj:Object) {
			super("player");
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var polygonShape:b2PolygonShape=new b2PolygonShape();		
			
			polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); // temporarily? a box
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.fixedRotation = true;
			
			// look at body y position to prevent it to be upside down
			bodyDef.position.Set(obj.x/WORLD_SCALE, obj.y/WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = obj.density;
			fixtureDef.restitution = PLAYER_RESTIT;
			fixtureDef.friction = PLAYER_FRICTION;

			playerBody = world.CreateBody(bodyDef);
			playerBody.CreateFixture(fixtureDef);
			playerBody.SetUserData(this);
			
			checkpointHeld = false;
			canJump = false;			
		}

		public function getBody():b2Body {
			return playerBody;
		}
				
		public function getCheckpointHeld():Boolean {
			return checkpointHeld;
		}

		public function getCanJump():Boolean {
			return canJump;
		}
		
		public function setCheckpointHeld(newCheckpointHeld:Boolean):void {
			checkpointHeld = newCheckpointHeld;
		}		
		
		public function setCanJump(newCanJump:Boolean):void {
			canJump = newCanJump;
		}
	}
	
}
