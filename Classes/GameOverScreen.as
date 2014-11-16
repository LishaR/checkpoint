package  {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class GameOverScreen extends MovieClip {

		public function GameOverScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			startOverButton.addEventListener(MouseEvent.CLICK, onStartOverButtonPress);
		}
		
		private function onStartOverButtonPress(e:Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.ON_PRESS_START_OVER));
		}
		
	}
	
}
