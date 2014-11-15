package  {
	
	import flash.events.Event;
	
	public class NavigationEvent extends Event {
		
		public static const ON_PRESS_MENU_PLAY:String = "onPressMenuPlay";
		
		public function NavigationEvent(type:String) {
			super(type);
		}

	}
	
}
