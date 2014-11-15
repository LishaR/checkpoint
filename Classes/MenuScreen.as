package  {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class MenuScreen extends MovieClip {

		public function MenuScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			playButton.addEventListener(MouseEvent.CLICK, onPlayButtonPress);
		}
		
		private function onPlayButtonPress(e:Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.ON_PRESS_MENU_PLAY));
		}
		
	}
	
}
