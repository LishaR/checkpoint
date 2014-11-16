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
	import flash.events.TouchEvent;
	
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
	
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
		
		public static var currentLevel:Number;
				
		// global variables per level
		private var checkpointLives:Number = 5;
		private var world:b2World;
		private var player:Player;
		private var goal:Goal;
		private var checkpoint:Checkpoint;
		private var pickupTimer:Number; // used to make sure the player doesn't pick up the checkpoint like 0.03 seconds after he throws it.

		private var dir = 0;
		
		private var maxY:Number;

		private var movingPlatforms:Vector.<MovingPlatform>;
		
		public function getWorld():b2World {
			return world;
		}
		public function PlayScreen(level:Number = 0) {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			movingPlatforms = new Vector.<MovingPlatform>();
			currentLevel = level;
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

			loadLevel(Levels.LEVEL_VECTOR[currentLevel]);
			
			// debugDraw();		
			
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
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
						drawShape(polyCoords2, 0x486cd3);
					break;
					
					case "spike":
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); 
						bodyDef.type = b2Body.b2_staticBody;
						drawSpikes(obj.x, obj.y, obj.w, obj.h);
					break;
					
					default:
						polygonShape.SetAsBox(obj.w/2/WORLD_SCALE, obj.h/2/WORLD_SCALE); 
						bodyDef.type = b2Body.b2_staticBody;
						trace("Level object type not set");
					break;
				}
				
				if (obj.type == "platform" || obj.type == "lava" || obj.type == "spike") {

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
						goal = new Goal(world, obj, this);
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
						movingPlatforms.push(new MovingPlatform(world, obj, this));
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
		
		// draws a shape of a particular color.
		// points is an array of points, with even indices as x coords, and odd as y coords
		// color is the color
		private function drawSpikes(x:Number, y:Number, w:Number, h:Number) {
			// add graphics for a particular shape
			var spikeData:BitmapData = new spikes() as BitmapData;
			var sampleBitmap:Bitmap = new Bitmap(spikeData);
			for (var i:Number = x - w/2; i < x + w/2; i += sampleBitmap.width) {
				var spike:Bitmap = new Bitmap(spikeData);
				spike.x = i;
				spike.y = y - spike.height*0.65;
				addChild(spike);
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
		
		public function onTap(e:TouchEvent): void {
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
		
		public function onJumpButtonPress(e:TouchEvent) {
			e.stopPropagation();
			if (player.getCanJump()) {
				player.getBody().SetLinearVelocity(new b2Vec2(player.getBody().GetLinearVelocity().x, -JUMP_STRENGTH));
				player.setCanJump(false);
			}
		}
		
		public function onLeftButtonPress(e:TouchEvent) {
			e.stopPropagation();
			dir = -1;
		}
		
		public function onRightButtonPress(e:TouchEvent) {
			e.stopPropagation();
			dir = 1;
		}
		
		public function onLeftButtonRelease(e:TouchEvent) {
			if (dir == -1) {
				dir = 0;
			}
		}
		
		public function onRightButtonRelease(e:TouchEvent) {
			if (dir == 1) {
				dir = 0;
			}
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
			if (!stage) return;
			
			pickupTimer -= 1/FRAME_RATE;
			
			Main.playOverlay.numCheckpoints.text = "" + checkpointLives;
			
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

				// kill everything
				while (numChildren > 0) {
					removeChildAt(0);
				}

				movingPlatforms = new Vector.<MovingPlatform>();

				checkpointLives -= 1;
				if (checkpointLives < 0) {
					dispatchEvent(new NavigationEvent(NavigationEvent.ON_GAME_OVER));
				}
				
				loadLevel(Levels.LEVEL_VECTOR[currentLevel]);
			} else if (player && (player.getDead() || player.getBody().GetPosition().y > maxY + Y_THRESHOLD)) {
				player.getBody().SetPosition(checkpoint.getBody().GetPosition());
				player.setDead(false);
			} else if (checkpoint && (checkpoint.getDead() || checkpoint.getBody().GetPosition().y > maxY + Y_THRESHOLD)) {
				checkpointLives -= 1;
				trace("Checkpoint lives: " + checkpointLives);
				if (checkpointLives < 0) {
					dispatchEvent(new NavigationEvent(NavigationEvent.ON_GAME_OVER));
				}
				
				checkpoint.getBody().SetPosition(CHECKPOINT_OFFSCREEN);
				player.setCheckpointHeld(true);
				checkpoint.setDead(false);
			}
			
			if (player.getInGoal()) {
				if (currentLevel < Levels.LEVEL_VECTOR.length) {
					while (numChildren > 0) {
						removeChildAt(0);
					}
					currentLevel += 1;
					loadLevel(Levels.LEVEL_VECTOR[currentLevel]);
				}
			}
			
			player.getBody().SetAwake(true);
			player.getBody().SetActive(true);
            world.Step(1/FRAME_RATE, CALCS_PER_TICK, CALCS_PER_TICK);
			var pos_x:Number = player.getBody().GetWorldCenter().x*WORLD_SCALE;
            var pos_y:Number = player.getBody().GetWorldCenter().y*WORLD_SCALE;
            x = Main.stageWidth/2-pos_x*scaleX;
            y = Main.stageHeight/2-pos_y*scaleY;
            world.ClearForces();
            world.DrawDebugData();

            if (player) {
            	player.tick();
            }
            
            if (checkpoint) {
            	checkpoint.tick();
            }
            
            if (goal) {
            	goal.tick();
            }
            
            if (movingPlatforms) {
            	var i:int;
	            for (i = 0; i < movingPlatforms.length; i++) {
	            	movingPlatforms[i].tick();
	            }
            }
            
        }
		
	}
	
}

