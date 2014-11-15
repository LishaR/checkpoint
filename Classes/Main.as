package  {
	
	import flash.display.MovieClip;
	
	public class Main extends MovieClip {
		
		private static var currentScreen:MovieClip;
		
		public static var menuScreen:MenuScreen;
		
		public static var stageWidth:Number;
		public static var stageHeight:Number;

		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stageWidth = stage.stageWidth;
			stageHeight= stage.stageHeight;
			
			init();
			trace("This is working.");
		}
		
		private function init():void {
			menuScreen = new MenuScreen();
			
			currentScreen = menuScreen;
			addChild(menuScreen);
			//otherscreens.visible = false;
		}

	}
	
}
