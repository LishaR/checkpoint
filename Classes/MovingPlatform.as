package  {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.Graphics;
    

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
    

    public class MovingPlatform extends Entity {
        
        private var screen:MovieClip;
        private var platformSprite:Sprite;

        private var platformX:int;
        private var platformY:int;
        private var platformW:int;
        private var platformH:int;

        private var polyCoords:Array;

        public function MovingPlatform(world:b2World, obj:Object, playScreen:MovieClip) {
            super("movingPlatform");
            screen = playScreen;
            
            
            var bodyDef:b2BodyDef = new b2BodyDef();
            var polygonShape:b2PolygonShape=new b2PolygonShape();   

            polygonShape.SetAsBox(obj.w/2/PlayScreen.WORLD_SCALE, obj.h/2/PlayScreen.WORLD_SCALE); // temporarily? a box
            bodyDef.type = b2Body.b2_kinematicBody;
            
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

            platformX = obj.x;
            platformY = obj.y;
            platformW = obj.w;
            platformH = obj.h;

            polyCoords = new Array(platformX-platformW/2, platformY - platformH/2, platformX+platformW/2, platformY-platformH/2, platformX+platformW/2, platformY+platformH/2, platformX-platformW/2, platformY+platformH/2);
            
            var bmp:Bitmap=new Bitmap(new BitmapData(platformW, platformH, false, 0x251e22));
            
            platformSprite = new Sprite();
            platformSprite.addChild(bmp);
            screen.addChild(platformSprite);

            platformSprite.x = platformX - platformW/2;
            platformSprite.y = platformY - platformH/2;

        }

        // draws a shape of a particular color.
        // points is an array of points, with even indices as x coords, and odd as y coords
        // color is the color
        private function drawShape(points, color) {
            // add graphics for a particular shape
            var g:Graphics = platformSprite.graphics;
            // create an array of the coordinates in the shape (which is a rectangle right now)
            // and then fill the graphics with those coordinates

            g.clear();

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
            
        }

        public function tick():void {

            var pos:b2Vec2 = getBody().GetPosition();

            platformSprite.x = pos.x*PlayScreen.WORLD_SCALE - platformW/2;
            platformSprite.y = pos.y*PlayScreen.WORLD_SCALE - platformH/2;


            
        }
    }
    
}
