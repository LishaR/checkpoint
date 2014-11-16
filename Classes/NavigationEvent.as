package  {
	
	import flash.events.Event;
	
	public class NavigationEvent extends Event {
		
		public static const ON_PRESS_MENU_PLAY:String = "onPressMenuPlay";
		public static const ON_PRESS_START:String = "onPressStart";
		public static const ON_GAME_OVER:String = "onGameOver";
		public static const ON_PRESS_START_OVER:String = "onPressStartOver";
		
		public function NavigationEvent(type:String) {
			super(type);
		}

	}
	
}
