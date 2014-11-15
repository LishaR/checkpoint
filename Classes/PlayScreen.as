package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.geom.Point;
	
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
	
	public class PlayScreen extends MovieClip {
		
		private static const CALCS_PER_TICK:int = 5; // iterations of physics engine per tick
		private static const FRAME_RATE:Number = 30; // frames per second
		private static const GRAVITY_STRENGTH:Number = 25; // m/s^2 ?
		private static const MAX_VELOCITY:Number = 7; // max player velocity in horizontal direction (running)
		private static const JUMP_STRENGTH:Number = 10; 
		private static const HORIZONTAL_ACCEL:Number = 1.5; // running acceleration
		private static const PLAYER_RESTIT:Number = 0.05; // player bounciness on a 0 to 1 scale
		private static const PLAYER_FRICTION:Number = 0.3; // player friction
		private static const CHECKPOINT_PICKUP_DIST:Number = 1.2; // distance the player has to be from checkpoint to pick it up
		private static const THROW_STRENGTH:Number = 10; // velocity the player throws the checkpoint
		private static const THROW_START_DIST:Number = 1; // distance from the player the checkpoint spawns from when it is thrown
		private static const PICKUP_DELAY:Number = 0.5; // min time after the checkpoint is thrown before it can be picked back up
		
		private const worldScale:Number = 20; // pixels per meter
		
		// global variables per level
		private var world:b2World;
		private var player:b2Body;
		private var goal:b2Body;
		private var checkpoint:b2Body;
		private var checkpointHeld:Boolean;
		private var pickupTimer:Number;
		
		public function PlayScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			init();
		}
		
		// initial PlayScreen setup
 		private function init():void {
			Input.initialize(stage);
			scaleX = 1;
			scaleY = 1;
			
			loadLevel(Levels.Level2);
			
			debugDraw();		
			
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		// Load one of the levels defined as static consts in Levels
		private function loadLevel(levelData:String) {
			world = new b2World(new b2Vec2(0, GRAVITY_STRENGTH), true);
			player = null;
			goal = null;
			checkpoint = null;
			checkpointHeld = false;
			pickupTimer = 0;
            var objects:Vector.<Object> = parse(levelData);
			for each (var obj:Object in objects) {
				
                var bodyDef:b2BodyDef = new b2BodyDef();
				var polygonShape:b2PolygonShape=new b2PolygonShape();		
				
               	switch (obj.type) {
					case "player":
						polygonShape.SetAsBox(obj.w/2/worldScale, obj.h/2/worldScale); // temporarily? a box
						bodyDef.type = b2Body.b2_dynamicBody;
						bodyDef.fixedRotation = true;
					break;
					
					case "goal":
						polygonShape.SetAsBox(obj.w/2/worldScale, obj.h/2/worldScale); // temporarily a box
						bodyDef.type = b2Body.b2_staticBody;
						bodyDef.fixedRotation = true;
					break;
					
					case "checkpoint":
						polygonShape.SetAsBox(obj.w/2/worldScale, obj.h/2/worldScale); // temporarily a box
						bodyDef.type = b2Body.b2_dynamicBody;
					break;
					
					case "platform":
						polygonShape.SetAsBox(obj.w/2/worldScale, obj.h/2/worldScale);
						bodyDef.type = b2Body.b2_staticBody;
					break;
					
					case "lava":
						polygonShape.SetAsBox(obj.w/2/worldScale, obj.h/2/worldScale); 
						bodyDef.type = b2Body.b2_staticBody;
					break;
					
					default:
						trace("Level object type not set");
				}
				
                // look at body y position to prevent it to be upside down
                bodyDef.position.Set(obj.x/worldScale, obj.y/worldScale);
				
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
                fixtureDef.shape = polygonShape;
                fixtureDef.density = obj.density;
                fixtureDef.restitution = obj.restit;
                fixtureDef.friction = obj.friction;
				
				var body:b2Body = world.CreateBody(bodyDef);
				body.CreateFixture(fixtureDef);
				
				// set global variables
				switch (obj.type) {
					case "player":
						player = body;
					break;
					
					case "goal":
						goal = body;
					break;
					
					case "checkpoint":
						checkpoint = body;
					break;
				}
			}
			if (player == null) {
				trace("Error: No player in level");
			}
			if (goal == null) {
				trace("Error: No goal in level");
			}
			if (checkpoint == null) {
				trace("Warning: No checkpoint in level");
			}
		}
		
		// Parse the input into a vector(parametrized array) of Objects
		// Implementation is NOT important to understand
		private function parse(objData:String):Vector.<Object> {
			var objArray:Vector.<Object>  = new Vector.<Object>;
			objData = objData.substr(1, objData.length - 1);
			for each (var data:String in objData.split(";")) {
				data = data.substr(2, data.length - 3);
				var props:Array = data.split(",");
				var obj:Object = new Object();
				obj.shape = String(props[0]).replace(/^\s+|\s+$/g, ''); // trim whitespace
				obj.x = Number(props[1]);
				obj.y = Number(props[2]);
				obj.w = Number(props[3]);
				obj.h = Number(props[4]);
				obj.a = Number(props[5]);
				obj.comment = String(props[6]).replace(/^\s+|\s+$/g, '');
				obj.type = String(props[7]).replace(/^\s+|\s+$/g, '');
				obj.density = Number(props[8]);
				obj.friction = Number(props[9]);
				obj.restit = Number(props[10]);
				if (obj.type == "player") {
					obj.restit = PLAYER_RESTIT;
					obj.friction = PLAYER_FRICTION;
				}
				objArray.push(obj);
			}
			return objArray;
		}
		
		
		// show object bounds for debugging purposes
        private function debugDraw():void {
            var debugDraw:b2DebugDraw = new b2DebugDraw();
            var debugSprite:Sprite = new Sprite();
            addChild(debugSprite);
            debugDraw.SetSprite(debugSprite);
            debugDraw.SetDrawScale(worldScale);
            debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
            debugDraw.SetFillAlpha(0.5);
            world.SetDebugDraw(debugDraw);
        }
		
		private function onMouseClick(e:MouseEvent) {
			var playerPos:b2Vec2 = player.GetWorldCenter();
			var mousePosX:Number = e.stageX - x;
			var mousePosY:Number = e.stageY - y;
			var playerX:Number = playerPos.x*worldScale;
			var playerY:Number = playerPos.y*worldScale;
			
			var dist:b2Vec2 = new b2Vec2(mousePosX - playerX, mousePosY - playerY);
			dist.Normalize();
			dist.Multiply(THROW_STRENGTH);
			
			var throwDist:b2Vec2 = dist.Copy();
			throwDist.Normalize();
			throwDist.Multiply(THROW_START_DIST);
			
			if (checkpointHeld) {
				var spawnPos:b2Vec2 = player.GetPosition().Copy();
				spawnPos.Add(throwDist);
				checkpoint.SetPosition(spawnPos);
				
				var vel:b2Vec2 = player.GetLinearVelocity().Copy();
				vel.Add(dist);
				checkpoint.SetLinearVelocity(vel);
				
				checkpointHeld = false;
				pickupTimer = PICKUP_DELAY;
			}
		}
		
		// called every tick
        private function onEnterFrame(e:Event):void {
			pickupTimer -= 1/FRAME_RATE;
			// collision detection
			if (checkpoint != null) {
				var dist:b2Vec2 = player.GetPosition().Copy();
				dist.Subtract(checkpoint.GetPosition());
				if (dist.Length() < CHECKPOINT_PICKUP_DIST && pickupTimer < 0) {
					checkpointHeld = true;
					checkpoint.SetPosition(new b2Vec2(int.MAX_VALUE, int.MAX_VALUE))
				}
			}
			
			// INPUT CLASS AND KEYCODES CLASS ARE TEMPORARY JUST FOR TESTING PURPOSES.  
			// It's code I found on the internet because I'm gonna get rid of it soon anyway.
			if (Input.kd("A", "LEFT")) {
				if (player.GetLinearVelocity().x > -MAX_VELOCITY) {
					player.ApplyImpulse(new b2Vec2(-HORIZONTAL_ACCEL, 0), player.GetWorldCenter());
				}
			}
			if (Input.kd("D", "RIGHT")) {
				if (player.GetLinearVelocity().x < MAX_VELOCITY) {
					player.ApplyImpulse(new b2Vec2(HORIZONTAL_ACCEL, 0), player.GetWorldCenter());
				}
			}
			
			if (Input.kd("W", "UP")) {
				player.SetLinearVelocity(new b2Vec2(player.GetLinearVelocity().x, -JUMP_STRENGTH));
			}
			
			player.SetActive(true);
            world.Step(1/FRAME_RATE, CALCS_PER_TICK, CALCS_PER_TICK);
			var pos_x:Number = player.GetWorldCenter().x*worldScale;
            var pos_y:Number = player.GetWorldCenter().y*worldScale;
            x = stage.stageWidth/2-pos_x*scaleX;
            y = stage.stageHeight/2-pos_y*scaleY;
            world.ClearForces();
            world.DrawDebugData();
        }
		
	}
	
}

