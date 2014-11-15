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
	
	public class Player extends Entity {
		private static const PLAYER_RESTIT:Number = 0.01; // player bounciness on a 0 to 1 scale
		private static const PLAYER_FRICTION:Number = 0.3; // player friction
		private static const WORLD_SCALE:Number = 20; // pixels per meter
		
		private var checkpointHeld:Boolean;
		private var canJump:Boolean;

		public var playerSprite:Bitmap;
		public var playerSpritesheet:Bitmap;
		public var playerFrame:BitmapData;
		private var playerRect:Rectangle;

		private var isLoaded:Boolean = false;

		var tileWidth:int = 32;
		var tileHeight:int = 64;
		var walkAnimStart:int = 3;
		var walkAnimEnd:int = 6;
		var animationIndex:int = 3;
		var animationCount:int = 0;
		var animationDelay:int = 2;

		private var myImageLoader:Loader;
		private var screen:MovieClip;


		private var dead:Boolean;

		public function loadSprite():void {

			playerFrame=new BitmapData(32,64,true, 0x00000000);
			myImageLoader = new Loader();
			//create a Loader instance
			//create a URLRequest instance to indicate the image source
			var myImageLocation:URLRequest = new URLRequest("assets/player_strip6.png");
			// load the bitmap data from the image source in the Loader instance
			myImageLoader.load(myImageLocation);
			// screen.addChild(myImageLoader);
			myImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, addSprite);
		}

		public function addSprite(e:Event):void {
			trace(myImageLoader.content);
			var bmp:Bitmap = myImageLoader.content as Bitmap;
			playerSpritesheet = new Bitmap(bmp.bitmapData);
			playerSprite = new Bitmap(playerFrame);
			trace(playerSprite);
			screen.addChild(playerSprite);

			isLoaded = true;

		}

		public function Player(world:b2World, obj:Object, playScreen:MovieClip) {
			super("player");
			screen = playScreen;
			
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

			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetUserData(this);
			
			checkpointHeld = false;
			canJump = false;

			playerRect=new Rectangle(0,0,32,64);			

			loadSprite();

			dead = false;
		}
				
		public function getCheckpointHeld():Boolean {
			return checkpointHeld;
		}

		public function getCanJump():Boolean {
			return canJump;
		}

		public function getDead():Boolean {
			return dead;
		}
		
		public function setCheckpointHeld(newCheckpointHeld:Boolean):void {
			checkpointHeld = newCheckpointHeld;
		}		
		
		public function setCanJump(newCanJump:Boolean):void {
			canJump = newCanJump;
		}

		public function tick():void {
			if (isLoaded) {
				if (Math.abs(getBody().GetLinearVelocity().x) > 1 &&  Math.abs(getBody().GetLinearVelocity().y) < 1 && canJump) {
					drawSpriteWalking();
				} else if (canJump) {
					drawSpriteIdle();
				}
				else {
					drawSpriteJumping();
				}
				
				var pos:b2Vec2 = getBody().GetPosition();

				playerSprite.x = pos.x*PlayScreen.WORLD_SCALE-16;
				playerSprite.y = pos.y*PlayScreen.WORLD_SCALE-32;

			}
			
		}

		private function drawSpriteWalking():void {
			
					if (animationCount == animationDelay) {
						animationIndex++;
						animationCount = 0;
						if (animationIndex == walkAnimEnd){
							animationIndex = walkAnimStart;
						}
					}else{
						animationCount++;
					}
				
				playerRect.x = int(animationIndex)*tileWidth;
				playerRect.y = 0;
				playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
		}

		private function drawSpriteIdle():void {
			
				playerRect.x = 0;
				playerRect.y = 0;
				playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
		}

		private function drawSpriteJumping():void {
			
				playerRect.x = tileWidth;
				playerRect.y = 0;
				playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
		}
		
		public function setDead(newDead:Boolean):void {
			dead = newDead;

		}
	}
	
}
