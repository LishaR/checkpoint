package  {
	
	import flash.display.*;
	import flash.events.Event;
	
	public class Main extends MovieClip {
		
		private static var currentScreen:MovieClip;
		
		public static var menuScreen:MenuScreen;
		public static var playScreen:PlayScreen;
		public static var playOverlay:PlayOverlay;
		public static var instructionsScreen:InstructionsScreen;
		public static var gameOverScreen:GameOverScreen;
		
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
			
			menuScreen.addEventListener(NavigationEvent.ON_PRESS_MENU_PLAY, onPressPlayButton);
		}
		
		private function onPressPlayButton(e:Event):void {
			removeEventListener(NavigationEvent.ON_PRESS_MENU_PLAY, onPressPlayButton);
			
			instructionsScreen = new InstructionsScreen();
			instructionsScreen.addEventListener(NavigationEvent.ON_PRESS_START, onPressStartButton);
			
			removeChild(currentScreen);
			currentScreen = instructionsScreen;
			addChild(instructionsScreen);
		}
		
		private function onPressStartButton(e:Event):void {
			removeEventListener(NavigationEvent.ON_PRESS_START, onPressStartButton);
			
			playScreen = new PlayScreen();
			playOverlay = new PlayOverlay(playScreen);
			playScreen.addEventListener(NavigationEvent.ON_GAME_OVER, onGameOver);
			
			removeChild(currentScreen);
			currentScreen = playScreen;
			addChild(playScreen);
		}
		
		private function onGameOver(e:Event):void {
			removeEventListener(NavigationEvent.ON_GAME_OVER, onGameOver);
			
			gameOverScreen = new GameOverScreen();
			gameOverScreen.addEventListener(NavigationEvent.ON_PRESS_START_OVER, onPressStartOver);
			
			removeChild(currentScreen);
			currentScreen = gameOverScreen;
			addChild(gameOverScreen);
		}
		
		private function onPressStartOver(e:Event):void {
			removeEventListener(NavigationEvent.ON_PRESS_START_OVER, onPressStartOver);
			
			playScreen = new PlayScreen(2);
			playScreen.addEventListener(NavigationEvent.ON_GAME_OVER, onGameOver);
			
			removeChild(currentScreen);
			currentScreen = playScreen;
			addChild(playScreen);
			addChild(playOverlay);
		}
	}
	
}
