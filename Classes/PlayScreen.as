﻿package  {
	
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
		private static const WORLD_SCALE:Number = 20; // pixels per meter
		
		private static const GRAVITY_STRENGTH:Number = 25; // m/s^2 ... this value isnt' 9.8 since the scales are a bit random.
		private static const MAX_VELOCITY:Number = 7; // max player velocity in horizontal direction (running)
		private static const JUMP_STRENGTH:Number = 10; 
		private static const HORIZONTAL_ACCEL:Number = 1.5; // running acceleration
		private static const CHECKPOINT_PICKUP_DIST:Number = 1.2; // distance the player has to be from checkpoint to pick it up
		private static const THROW_STRENGTH:Number = 10; // velocity the player throws the checkpoint
		private static const THROW_START_DIST:Number = 1; // distance from the player the checkpoint spawns from when it is thrown
		private static const PICKUP_DELAY:Number = 0.2; // min time after the checkpoint is thrown before it can be picked back up
		
		private static const REGULAR_CHECKPOINT_RESTIT:Number = 0.1; // bounciness on a 0 to 1 scale
		private static const REGULAR_CHECKPOINT_FRICTION:Number = 0.3; // 0 to 1 scale
		private static const BOUNCY_CHECKPOINT_RESTIT:Number = 0.7; // bounciness on a 0 to 1 scale
		private static const BOUNCY_CHECKPOINT_FRICTION:Number = 0.05; // 0 to 1 scale
				
		// global variables per level
		private var world:b2World;
		private var player:Player;
		private var goal:b2Body;
		private var checkpoint:b2Body;
		private var pickupTimer:Number; // used to make sure the player doesn't pick up the checkpoint like 0.03 seconds after he throws it.
		
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
			var contactListener = new ContactListener();
			world.SetContactListener(contactListener);
			
			player = null;
			goal = null;
			checkpoint = null;
			pickupTimer = 0;
            var objects:Vector.<Object> = parse(levelData);
			for each (var obj:Object in objects) {
				
                var bodyDef:b2BodyDef = new b2BodyDef();
				var polygonShape:b2PolygonShape=new b2PolygonShape();		
				
               	switch (obj.type) {
					case "goal":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); // temporarily a box
						bodyDef.type = b2Body.b2_staticBody;
						bodyDef.fixedRotation = true;
					break;
					
					case "checkpoint":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); // temporarily a box
						bodyDef.type = b2Body.b2_dynamicBody;
					break;
					
					case "bouncyCheckpoint":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); // temporarily a box
						bodyDef.type = b2Body.b2_dynamicBody;
					break;
					
					case "platform":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE);
						bodyDef.type = b2Body.b2_staticBody;
					break;
					
					case "lava":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); 
						bodyDef.type = b2Body.b2_staticBody;
					break;
					
					default:
						trace("Level object type not set");
				}
				
				if (obj.type != "player") {
					// look at body y position to prevent it to be upside down
					bodyDef.position.Set(obj.x/WORLD_SCALE, obj.y/WORLD_SCALE);
					
					var fixtureDef:b2FixtureDef = new b2FixtureDef();
					fixtureDef.shape = polygonShape;
					fixtureDef.density = obj.density;
					fixtureDef.restitution = obj.restit;
					fixtureDef.friction = obj.friction;
					
					var body:b2Body = world.CreateBody(bodyDef);
					body.CreateFixture(fixtureDef);
				}
					
				// set global variables
				switch (obj.type) {
					case "player":
						player = new Player(world, obj);
					break;
					
					case "goal":
						goal = body;
					break;
					
					case "bouncyCheckpoint":
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
				if (obj.type == "checkpoint") {
					obj.restit = REGULAR_CHECKPOINT_RESTIT;
					obj.friction = REGULAR_CHECKPOINT_FRICTION;
				} else if (obj.type == "bouncyCheckpoint") {
					obj.restit = BOUNCY_CHECKPOINT_RESTIT;
					obj.friction = BOUNCY_CHECKPOINT_FRICTION;
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
            debugDraw.SetDrawScale(WORLD_SCALE);
            debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
            debugDraw.SetFillAlpha(0.5);
            world.SetDebugDraw(debugDraw);
        }
		
		// for now, mouse clicks throw the checkpoint when available.
		private function onMouseClick(e:MouseEvent) {
			var playerPos:b2Vec2 = player.getBody().GetWorldCenter();
			var mousePosX:Number = e.stageX - x;
			var mousePosY:Number = e.stageY - y;
			var playerX:Number = playerPos.x*WORLD_SCALE;
			var playerY:Number = playerPos.y*WORLD_SCALE;
			
			var dist:b2Vec2 = new b2Vec2(mousePosX - playerX, mousePosY - playerY);
			dist.Normalize();
			dist.Multiply(THROW_STRENGTH);
			
			var throwDist:b2Vec2 = dist.Copy();
			throwDist.Normalize();
			throwDist.Multiply(THROW_START_DIST);
			
			if (player.getCheckpointHeld()) {
				var spawnPos:b2Vec2 = player.getBody().GetPosition().Copy();
				spawnPos.Add(throwDist);
				checkpoint.SetPosition(spawnPos);
				
				var vel:b2Vec2 = player.getBody().GetLinearVelocity().Copy();
				vel.Add(dist);
				checkpoint.SetLinearVelocity(vel);
				
				player.setCheckpointHeld(false);
				pickupTimer = PICKUP_DELAY;
			}
		}
		
		// called every tick
        private function onEnterFrame(e:Event):void {
			pickupTimer -= 1/FRAME_RATE;
			// collision detection
			if (checkpoint != null) {
				var dist:b2Vec2 = player.getBody().GetPosition().Copy();
				dist.Subtract(checkpoint.GetPosition());
				if (dist.Length() < CHECKPOINT_PICKUP_DIST && pickupTimer < 0) {
					player.setCheckpointHeld(true);
					// LOLZ hack to make the checkpoint disappear without removing it
					// There isn't an easy way to remove the checkpoint without totally destroying it
					// and having to recreate it.  
					checkpoint.SetPosition(new b2Vec2(int.MAX_VALUE, int.MAX_VALUE)) 
				}
			}
			
			// INPUT CLASS AND KEYCODES CLASS ARE TEMPORARY JUST FOR TESTING PURPOSES.  
			// It's code I found on the internet because I'm gonna get rid of it soon anyway.
			if (Input.kd("A", "LEFT")) {
				if (player.getBody().GetLinearVelocity().x > -MAX_VELOCITY) {
					player.getBody().ApplyImpulse(new b2Vec2(-HORIZONTAL_ACCEL, 0), player.getBody().GetWorldCenter());
				}
			}
			if (Input.kd("D", "RIGHT")) {
				if (player.getBody().GetLinearVelocity().x < MAX_VELOCITY) {
					player.getBody().ApplyImpulse(new b2Vec2(HORIZONTAL_ACCEL, 0), player.getBody().GetWorldCenter());
				}
			}
			
			if (Input.kd("W", "UP")) {
				// hack to make player wake up.... FIX LATER
				player.getBody().SetLinearVelocity(new b2Vec2(player.getBody().GetLinearVelocity().x, -JUMP_STRENGTH));
			}
			
			player.getBody().SetAwake(true);
			player.getBody().SetActive(true);
            world.Step(1/FRAME_RATE, CALCS_PER_TICK, CALCS_PER_TICK);
			var pos_x:Number = player.getBody().GetWorldCenter().x*WORLD_SCALE;
            var pos_y:Number = player.getBody().GetWorldCenter().y*WORLD_SCALE;
            x = stage.stageWidth/2-pos_x*scaleX;
            y = stage.stageHeight/2-pos_y*scaleY;
            world.ClearForces();
            world.DrawDebugData();
        }
		
	}
	
}
