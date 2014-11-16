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
		
		private var checkpointHeld:Boolean;
		private var canJump:Boolean;
		private var inGoal:Boolean;
		private var dead:Boolean;

		public var playerSprite:Bitmap;
		public var playerSpritesheet:Bitmap;
		public var playerSpritesheetLeft:Bitmap;
		public var playerFrame:BitmapData;
		private var playerRect:Rectangle;

		private var isLoaded:Boolean = false;

		var tileWidth:int = 32;
		var tileHeight:int = 48;
		var walkAnimStart:int = 3;
		var walkAnimEnd:int = 6;
		var animationIndex:int = 3;
		var animationCount:int = 0;
		var animationDelay:int = 2;

		private var myImageLoader:Loader;
		private var myImageLoader2:Loader;
		private var screen:MovieClip;

		private var orientation:Boolean = true;

		private var playerW:int;
		private var playerH:int;

		public function loadSprite():void {

			playerFrame=new BitmapData(32,48,true, 0x00000000);
			
			myImageLoader = new Loader();
			//create a Loader instance
			//create a URLRequest instance to indicate the image source
			var myImageLocation:URLRequest = new URLRequest("assets/player_left_strip6.png");
			// load the bitmap data from the image source in the Loader instance
			myImageLoader.load(myImageLocation);
			// screen.addChild(myImageLoader);
			myImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, addSprite);
		}

		public function addSprite(e:Event):void {
			myImageLoader2 = new Loader();
			var myImageLocation:URLRequest = new URLRequest("assets/player_strip6.png");
			myImageLoader2.load(myImageLocation);

			myImageLoader2.contentLoaderInfo.addEventListener(Event.COMPLETE, addSprite2);
			
			var bmp:Bitmap = myImageLoader.content as Bitmap;
			playerSpritesheetLeft = new Bitmap(bmp.bitmapData);
			
		}
		public function addSprite2(e:Event):void {
			var bmp:Bitmap = myImageLoader2.content as Bitmap;
			playerSpritesheet = new Bitmap(bmp.bitmapData);
			
			playerSprite = new Bitmap(playerFrame);
			screen.addChild(playerSprite);

			isLoaded = true;

		}

		public function Player(world:b2World, obj:Object, playScreen:MovieClip) {
			super("player");
			screen = playScreen;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var polygonShape:b2PolygonShape=new b2PolygonShape();		

			playerW = obj.w;
			playerH = obj.h;
			
			polygonShape.SetAsBox(obj.w/2/PlayScreen.WORLD_SCALE, obj.h/2/PlayScreen.WORLD_SCALE); // temporarily? a box
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.fixedRotation = true;
			
			// look at body y position to prevent it to be upside down
			bodyDef.position.Set(obj.x/PlayScreen.WORLD_SCALE, obj.y/PlayScreen.WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = obj.density;
			fixtureDef.restitution = PLAYER_RESTIT;
			fixtureDef.friction = PLAYER_FRICTION;

			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetUserData(this);
			
			checkpointHeld = false;
			canJump = true;
			dead = false;
			inGoal = false;

			playerRect=new Rectangle(0,0,32,64);			

			loadSprite();
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
		
		public function getInGoal():Boolean {
			return inGoal;
		}
		
		public function setCheckpointHeld(newCheckpointHeld:Boolean):void {
			checkpointHeld = newCheckpointHeld;
		}		
		
		public function setCanJump(newCanJump:Boolean):void {
			canJump = newCanJump;
		}
		
		public function setDead(newDead:Boolean):void {
			dead = newDead;
		}
		
		public function setInGoal(newInGoal:Boolean):void {
			inGoal = newInGoal;
		}

		public function tick():void {
			if (isLoaded) {
				if (getBody().GetLinearVelocity().x > 0.3) {
					orientation = true;
				}
				else if (getBody().GetLinearVelocity().x < -0.3) {
					orientation = false;
				}

				if (Math.abs(getBody().GetLinearVelocity().x) > 1 &&  Math.abs(getBody().GetLinearVelocity().y) < 1 && canJump) {
					drawSpriteWalking(orientation);
				} else if (canJump) {
					drawSpriteIdle(orientation);
				}
				else {
					drawSpriteJumping(orientation);
				}
				
				if (getBody().GetLinearVelocity().x > 0) {

				}
				var pos:b2Vec2 = getBody().GetPosition();



				playerSprite.x = pos.x*PlayScreen.WORLD_SCALE-tileWidth/2;
				playerSprite.y = pos.y*PlayScreen.WORLD_SCALE+playerH/2- tileHeight + 2;

			}
			
		}

		private function drawSpriteWalking(orientation:Boolean = true):void {
			
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
				if (orientation) {
					playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
				}
				else {
					playerFrame.copyPixels(playerSpritesheetLeft.bitmapData,playerRect, new Point(0,0));
				}
		}

		private function drawSpriteIdle(orientation:Boolean = true):void {
			
				playerRect.x = 0;
				playerRect.y = 0;
				playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
				if (orientation) {
					playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
				}
				else {
					playerFrame.copyPixels(playerSpritesheetLeft.bitmapData,playerRect, new Point(0,0));
				}
		}

		private function drawSpriteJumping(orientation:Boolean = true):void {
			
				playerRect.x = tileWidth;
				playerRect.y = 0;
				playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
				if (orientation) {
					playerFrame.copyPixels(playerSpritesheet.bitmapData,playerRect, new Point(0,0));
				}
				else {
					playerFrame.copyPixels(playerSpritesheetLeft.bitmapData,playerRect, new Point(0,0));
				}
		}

	}
	
}
