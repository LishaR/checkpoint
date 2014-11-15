package  {
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
	
	public class Checkpoint extends Entity {
		private static const CHECKPOINT_RESTIT:Number = 0.1; // checkpoint bounciness on a 0 to 1 scale
		private static const CHECKPOINT_FRICTION:Number = 0.3; // checkpoint friction
		private static const WORLD_SCALE:Number = 20; // pixels per meter
		
		private var dead:Boolean;
		
		public function Checkpoint(world:b2World, obj:Object) {
			super("checkpoint");
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var polygonShape:b2PolygonShape=new b2PolygonShape();		
			
			polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); // temporarily? a box
			bodyDef.type = b2Body.b2_dynamicBody;
			
			// look at body y position to prevent it to be upside down
			bodyDef.position.Set(obj.x/WORLD_SCALE, obj.y/WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = obj.density;
			fixtureDef.restitution = CHECKPOINT_RESTIT;
			fixtureDef.friction = CHECKPOINT_FRICTION;

			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetUserData(this);
			
			dead = false;
		}

		public function getDead():Boolean {
			return dead;
		}
		
		public function setDead(newDead:Boolean):void {
			dead = newDead;
		}
	}
	
}
