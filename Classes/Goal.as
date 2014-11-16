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
	

	public class Goal extends Entity {

        private var isLoaded:Boolean = false;
        
        private var screen:MovieClip;
        private var myImageLoader:Loader;

        public var goalSprite:Bitmap;
        public var goalFrame:BitmapData;


        private var goalW:int;
        private var goalH:int;
			
		public function Goal(world:b2World, obj:Object, playScreen:MovieClip) {
			super("goal");

            screen = playScreen;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var polygonShape:b2PolygonShape=new b2PolygonShape();	

			polygonShape.SetAsBox(obj.w/2/PlayScreen.WORLD_SCALE, obj.h/2/PlayScreen.WORLD_SCALE); // temporarily a box
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.fixedRotation = true;
			

            goalW = obj.w;
            goalH = obj.h;

			// look at body y position to prevent it to be upside down
			bodyDef.position.Set(obj.x/PlayScreen.WORLD_SCALE, obj.y/PlayScreen.WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = obj.density;
			fixtureDef.restitution = obj.restit;
			fixtureDef.friction = obj.friction;

			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetUserData(this);

            myImageLoader = new Loader();
            //create a Loader instance
            //create a URLRequest instance to indicate the image source
            var myImageLocation:URLRequest = new URLRequest("assets/goal.png");
            // load the bitmap data from the image source in the Loader instance
            myImageLoader.load(myImageLocation);
            // screen.addChild(myImageLoader);
            myImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, addSprite);
        }

        public function addSprite(e:Event):void {
            var bmp:Bitmap = myImageLoader.content as Bitmap;
            goalSprite = new Bitmap(bmp.bitmapData);
            screen.addChild(goalSprite);

            isLoaded = true;
        }

        public function tick():void {
            if (isLoaded) {

                var pos:b2Vec2 = getBody().GetPosition();

                goalSprite.x = pos.x*PlayScreen.WORLD_SCALE-32;
                goalSprite.y = pos.y*PlayScreen.WORLD_SCALE-64 + goalH/2;

            }
            
        }
	}
	
}