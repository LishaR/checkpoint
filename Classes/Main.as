package  {
	
	import flash.display.*;
	import flash.events.Event;
	
	public class Main extends MovieClip {
		
		private static var currentScreen:MovieClip;
		
		public static var menuScreen:MenuScreen;
		public static var playScreen:PlayScreen;
		public static var playOverlay:PlayOverlay;
		
		public static var stageWidth:Number;
		public static var stageHeight:Number;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stageWidth = stage.stageWidth;
			stageHeight= stage.stageHeight;
			
			init();
		}
		
		private function init():void {
			menuScreen = new MenuScreen();
			addChild(menuScreen);
			currentScreen = menuScreen;
			
			Sound.play(Sound.MUSIC);
			
			menuScreen.addEventListener(NavigationEvent.ON_PRESS_MENU_PLAY, onPressPlayButton);
		}
		
		private function onPressPlayButton(e:Event):void {
			removeEventListener(NavigationEvent.ON_PRESS_MENU_PLAY, onPressPlayButton);
			
			playScreen = new PlayScreen();
			playOverlay = new PlayOverlay(playScreen);
			
			removeChild(currentScreen);
			currentScreen = playScreen;
			addChild(playScreen);
			addChild(playOverlay);
		}

	}
	
}
