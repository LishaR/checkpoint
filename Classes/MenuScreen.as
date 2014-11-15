package  {
	
	import flash.events.Event;
	
	public class MenuScreen extends MovieClip {

		public function MenuScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			aboutButton.addEventListener(, onAboutButtonPress);
			playButton.addEventListener(, onPlayButtonPress);
		}
		
		private function onAboutButtonPress(e:Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.ON_PRESS_));
		}
		
		private function onPlayButtonPress(e:Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.ON_PRESS_));
		}

	}
	
}
