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
			
			Sound.play(Sound.MUSIC);
			
			menuScreen.addEventListener(NavigationEvent.ON_PRESS_MENU_PLAY, onPressPlayButton);
		}
		
		private function onPressPlayButton(e:Event):void {
			menuScreen.removeEventListener(NavigationEvent.ON_PRESS_MENU_PLAY, onPressPlayButton);
			
			instructionsScreen = new InstructionsScreen();
			instructionsScreen.addEventListener(NavigationEvent.ON_PRESS_START, onPressStartButton);
			
			removeChild(currentScreen);
			currentScreen = instructionsScreen;
			addChild(instructionsScreen);
		}
		
		private function onPressStartButton(e:Event):void {
			instructionsScreen.removeEventListener(NavigationEvent.ON_PRESS_START, onPressStartButton);
			
			playScreen = new PlayScreen();
			playOverlay = new PlayOverlay(playScreen);
			playScreen.addEventListener(NavigationEvent.ON_GAME_OVER, onGameOver);
			
			removeChild(currentScreen);
			currentScreen = playScreen;
			addChild(playScreen);
			addChild(playOverlay);
		}
		
		private function onGameOver(e:Event):void {
			playScreen.removeEventListener(NavigationEvent.ON_GAME_OVER, onGameOver);
			
			gameOverScreen = new GameOverScreen();
			gameOverScreen.addEventListener(NavigationEvent.ON_PRESS_START_OVER, onPressStartOver);
			
			removeChild(playOverlay);
			removeChild(currentScreen);
			currentScreen = gameOverScreen;
			addChild(gameOverScreen);
		}
		
		private function onPressStartOver(e:Event):void {
			gameOverScreen.removeEventListener(NavigationEvent.ON_PRESS_START_OVER, onPressStartOver);
			
			playScreen = new PlayScreen(PlayScreen.currentLevel);
			playOverlay = new PlayOverlay(playScreen);
			playScreen.addEventListener(NavigationEvent.ON_GAME_OVER, onGameOver);
			
			removeChild(currentScreen);
			currentScreen = playScreen;
			addChild(playScreen);
			addChild(playOverlay);
		}
	}
	
}
