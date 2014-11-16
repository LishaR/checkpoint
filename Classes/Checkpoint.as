package  {
	import flash.display.MovieClip;

	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;

    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
	

	public class Checkpoint extends Entity {
		private static const CHECKPOINT_RESTIT:Number = 0.1; // checkpoint bounciness on a 0 to 1 scale
		private static const CHECKPOINT_FRICTION:Number = 0.3; // checkpoint friction
		
		private var dead:Boolean;
		private var isLoaded:Boolean = false;
		
		private var screen:MovieClip;
		private var myImageLoader:Loader;


		public var checkpointSprite:Bitmap;
		public var checkpointFrame:BitmapData;
		
			
		private var checkpointW:int;
		private var checkpointH:int;
			
		public function Checkpoint(world:b2World, obj:Object, playScreen:MovieClip) {
			super("checkpoint");
			screen = playScreen;
			
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var polygonShape:b2PolygonShape=new b2PolygonShape();	

			checkpointW = obj.w;
			checkpointH = obj.h;
				
			
			polygonShape.SetAsBox(obj.w/2/PlayScreen.WORLD_SCALE, obj.h/2/PlayScreen.WORLD_SCALE); // temporarily? a box
			bodyDef.type = b2Body.b2_dynamicBody;
			
			// look at body y position to prevent it to be upside down
			bodyDef.position.Set(obj.x/PlayScreen.WORLD_SCALE, obj.y/PlayScreen.WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = obj.density;
			fixtureDef.restitution = CHECKPOINT_RESTIT;
			fixtureDef.friction = CHECKPOINT_FRICTION;

			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetUserData(this);
			
			addSprite();

			dead = false;
		}

		public function addSprite():void {
			checkpointSprite = new Bitmap(new checkpoint());
			screen.addChild(checkpointSprite);

			isLoaded = true;
		}

		public function getDead():Boolean {
			return dead;
		}
		
		public function setDead(newDead:Boolean):void {
			dead = newDead;
		}

		public function tick():void {
			if (isLoaded) {

				var pos:b2Vec2 = getBody().GetPosition();

				checkpointSprite.x = pos.x*PlayScreen.WORLD_SCALE-16;
				checkpointSprite.y = pos.y*PlayScreen.WORLD_SCALE-32 + checkpointH/2 + 1;

			}
			
		}
	}
	
}
