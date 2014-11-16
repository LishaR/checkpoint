package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.TransformGestureEvent;
	import flash.events.MouseEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
	
	public class PlayScreen extends MovieClip {
		
		private static const CALCS_PER_TICK:int = 5; // iterations of physics engine per tick
		private static const FRAME_RATE:Number = 30; // frames per second
		public static const WORLD_SCALE:Number = 20; // pixels per meter
		
		private static const GRAVITY_STRENGTH:Number = 25; // m/s^2 ... this value isnt' 9.8 since the scales are a bit random.
		private static const MAX_VELOCITY:Number = 7; // max player velocity in horizontal direction (running)
		private static const JUMP_STRENGTH:Number = 10; 
		private static const HORIZONTAL_ACCEL:Number = 1.5; // running acceleration
		private static const CHECKPOINT_PICKUP_DIST:Number = 1.2; // distance the player has to be from checkpoint to pick it up
		private static const THROW_STRENGTH:Number = 15; // velocity the player throws the checkpoint
		private static const THROW_START_DIST:Number = 1; // distance from the player the checkpoint spawns from when it is thrown
		private static const PICKUP_DELAY:Number = 0.2; // min time after the checkpoint is thrown before it can be picked back up
		private static const Y_THRESHOLD:Number = 15;
		
		private static const CHECKPOINT_OFFSCREEN:b2Vec2 = new b2Vec2(-99999, -99999);
				
		// global variables per level
		private var checkpointLives:Number = 5;
		private var world:b2World;
		private var player:Player;
		private var goal:b2Body;
		private var checkpoint:Checkpoint;
		private var pickupTimer:Number; // used to make sure the player doesn't pick up the checkpoint like 0.03 seconds after he throws it.

		private var dir = 0;
		
		private var maxY:Number;
		
		private var currentLevel:Number;
		
		public function getWorld():b2World {
			return world;
		}
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
			currentLevel = 0;
			

			Multitouch.inputMode = MultitouchInputMode.GESTURE;

			stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE , onSwipe);
			
			loadLevel(Levels.LEVEL_VECTOR[0]);
			
			//debugDraw();		
			
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			leftButton.addEventListener(MouseEvent.MOUSE_DOWN, onLeftButtonPress);
			rightButton.addEventListener(MouseEvent.MOUSE_DOWN, onRightButtonPress);
			jumpButton.addEventListener(MouseEvent.MOUSE_DOWN, onJumpButtonPress);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		// Load one of the levels defined as static consts in Levels
		private function loadLevel(levelData:String) {
			world = new b2World(new b2Vec2(0, GRAVITY_STRENGTH), true);
			player = null;
			goal = null;
			checkpoint = null;
			pickupTimer = 0;
			maxY = -99999;
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
					
					case "platform":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE);
						bodyDef.type = b2Body.b2_staticBody;
						var polyCoords:Array = new Array(obj.x-obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y+obj.h/2, obj.x-obj.w/2, obj.y+obj.h/2);
						drawShape(polyCoords, 0x251e22);
					break;
					
					case "lava":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); 
						bodyDef.type = b2Body.b2_staticBody;
						var polyCoords2:Array = new Array(obj.x-obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y+obj.h/2, obj.x-obj.w/2, obj.y+obj.h/2);
						drawShape(polyCoords2, 0x4f403a);
					break;
					
					case "spike":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); 
						bodyDef.type = b2Body.b2_staticBody;
						var polyCoords3:Array = new Array(obj.x-obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y+obj.h/2, obj.x-obj.w/2, obj.y+obj.h/2);
						drawShape(polyCoords3, 0x4f403a);
					break;
					
					case "movingPlatform":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE);
						bodyDef.type = b2Body.b2_staticBody;

						var polyCoords4:Array = new Array(obj.x-obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y-obj.h/2, obj.x+obj.w/2, obj.y+obj.h/2, obj.x-obj.w/2, obj.y+obj.h/2);
						drawShape(polyCoords4, 0x251e22);
					break;
					
					default:
						trace("Level object type not set");
				}
				
				if (obj.type != "player" && obj.type != "checkpoint" && obj.type != "bouncyCheckpoint") {
					// look at body y position to prevent it to be upside down
					bodyDef.position.Set(obj.x/WORLD_SCALE, obj.y/WORLD_SCALE);
					if (obj.y/WORLD_SCALE > maxY) {
						maxY = obj.y/WORLD_SCALE;
					}
					
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
						player = new Player(world, obj, this);
					break;
					
					case "goal":
						goal = body;
						goal.SetUserData(new Entity("goal", goal));
					break;
					
					case "bouncyCheckpoint":
					case "checkpoint":
						checkpoint = new Checkpoint(world, obj, this);
					
						var contactListener:ContactListener = new ContactListener(checkpoint.getBody());
						world.SetContactListener(contactListener);
					break;
					
					case "platform":
						body.SetUserData(new Entity("platform", body));
					break;
					
					case "lava":
						body.SetUserData(new Entity("lava", body));
					break;
					
					case "movingPlatform":
						body.SetUserData(new Entity("movingPlatform", body));
					break;
					
					case "spike":
						body.SetUserData(new Entity("spike", body));
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
			
			trace(maxY);
		}

		// draws a shape of a particular color.
		// points is an array of points, with even indices as x coords, and odd as y coords
		// color is the color
		private function drawShape(points, color) {
			// add graphics for a particular shape
			var platformImg:Sprite = new Sprite();
			var g:Graphics = platformImg.graphics;
			// create an array of the coordinates in the shape (which is a rectangle right now)
			// and then fill the graphics with those coordinates

			// fill all platforms with this color (pure black at the moment)
			g.beginFill(color);

			// and then iterate through all the points in the point array to create the shape
			for(var i:int = 0; i < points.length; i += 2){
			    if(i == 0){
			        g.moveTo(points[i], points[i + 1]);
			    } else {
			        g.lineTo(points[i], points[i + 1]);
			    }
			}
			g.endFill();
			// add a mouse-event to the hotspot etc.
			addChild(platformImg);
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
		private function onMouseDown(e:MouseEvent) {
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
				checkpoint.getBody().SetPosition(spawnPos);
				
				var vel:b2Vec2 = player.getBody().GetLinearVelocity().Copy();
				vel.Add(dist);
				checkpoint.getBody().SetLinearVelocity(vel);
				
				player.setCheckpointHeld(false);
				pickupTimer = PICKUP_DELAY;
			}
		}
		
		private function onJumpButtonPress(e:MouseEvent) {
			e.stopPropagation();
			if (player.getCanJump()) {
				player.getBody().SetLinearVelocity(new b2Vec2(player.getBody().GetLinearVelocity().x, -JUMP_STRENGTH));
				player.setCanJump(false);
			}
		}
		
		private function onLeftButtonPress(e:MouseEvent) {
			e.stopPropagation();
			dir = -1;
		}
		
		private function onRightButtonPress(e:MouseEvent) {
			e.stopPropagation();
			dir = 1;
		}
		
		private function onMouseUp(e:MouseEvent) {
			dir = 0;
		}
		
		private function onSwipe(e:TransformGestureEvent) {
			var dist:b2Vec2 = new b2Vec2(e.offsetX, e.offsetY);
			dist.Normalize();
			dist.Multiply(THROW_STRENGTH);
			
			var throwDist:b2Vec2 = dist.Copy();
			throwDist.Normalize();
			throwDist.Multiply(THROW_START_DIST);
			
			if (player.getCheckpointHeld()) {
				var spawnPos:b2Vec2 = player.getBody().GetPosition().Copy();
				spawnPos.Add(throwDist);
				checkpoint.getBody().SetPosition(spawnPos);
				
				var vel:b2Vec2 = player.getBody().GetLinearVelocity().Copy();
				vel.Add(dist);
				checkpoint.getBody().SetLinearVelocity(vel);
				
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
				dist.Subtract(checkpoint.getBody().GetPosition());
				if (dist.Length() < CHECKPOINT_PICKUP_DIST && pickupTimer < 0) {
					player.setCheckpointHeld(true);
					// LOLZ hack to make the checkpoint disappear without removing it
					checkpoint.getBody().SetPosition(CHECKPOINT_OFFSCREEN);
				}
			}
			
			// INPUT CLASS AND KEYCODES CLASS ARE TEMPORARY JUST FOR TESTING PURPOSES.  
			// It's code I found on the internet because I'm gonna get rid of it soon anyway.
			if (Input.kd("A", "LEFT") || dir == -1) {
				if (player.getBody().GetLinearVelocity().x > -MAX_VELOCITY) {
					player.getBody().ApplyImpulse(new b2Vec2(-HORIZONTAL_ACCEL, 0), player.getBody().GetWorldCenter());
				}
			}
			if (Input.kd("D", "RIGHT") || dir == 1) {
				if (player.getBody().GetLinearVelocity().x < MAX_VELOCITY) {
					player.getBody().ApplyImpulse(new b2Vec2(HORIZONTAL_ACCEL, 0), player.getBody().GetWorldCenter());
				}
			}
			
			if (Input.kd("W", "UP", "SPACE") && player.getCanJump()) {
				player.getBody().SetLinearVelocity(new b2Vec2(player.getBody().GetLinearVelocity().x, -JUMP_STRENGTH));
				player.setCanJump(false);
			}
			
			if ((player.getDead() || player.getBody().GetPosition().y > maxY + Y_THRESHOLD)
				&& player.getCheckpointHeld()) {
				while (numChildren > 0) {
					removeChildAt(0);
				}
				addChild(leftButton);
				addChild(rightButton);
				addChild(jumpButton);
				loadLevel(Levels.LEVEL_VECTOR[currentLevel]);
			} else if (player.getDead() || player.getBody().GetPosition().y > maxY + Y_THRESHOLD) {
				player.getBody().SetPosition(checkpoint.getBody().GetPosition());
				player.setDead(false);
			} else if (checkpoint.getDead() || checkpoint.getBody().GetPosition().y > maxY + Y_THRESHOLD) {
				checkpointLives -= 1;
				trace("Checkpoint lives: " + checkpointLives);
				checkpoint.getBody().SetPosition(CHECKPOINT_OFFSCREEN);
				player.setCheckpointHeld(true);
				checkpoint.setDead(false);
			}
			
			if (player.getInGoal()) {
				if (currentLevel < Levels.LEVEL_VECTOR.length) {
					while (numChildren > 0) {
						removeChildAt(0);
					}
					addChild(leftButton);
					addChild(rightButton);
					addChild(jumpButton);
					currentLevel += 1;
					loadLevel(Levels.LEVEL_VECTOR[currentLevel]);
				}
			}
			
			player.getBody().SetAwake(true);
			player.getBody().SetActive(true);
            world.Step(1/FRAME_RATE, CALCS_PER_TICK, CALCS_PER_TICK);
			var pos_x:Number = player.getBody().GetWorldCenter().x*WORLD_SCALE;
            var pos_y:Number = player.getBody().GetWorldCenter().y*WORLD_SCALE;
            x = stage.stageWidth/2-pos_x*scaleX;
            y = stage.stageHeight/2-pos_y*scaleY;
			leftButton.x = -x;
			leftButton.y = -y + stage.stageHeight - leftButton.height;
			rightButton.x = -x + leftButton.width;
			rightButton.y = -y + stage.stageHeight - rightButton.height;
			jumpButton.x = -x + stage.stageWidth - jumpButton.width;
			jumpButton.y = -y + stage.stageHeight - jumpButton.height;
            world.ClearForces();
            world.DrawDebugData();

            player.tick();
            checkpoint.tick();
        }
		
	}
	
}

