package  {
		
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
		
	public class InstructionsScreen extends MovieClip {
		
		public function InstructionsScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			startButton.addEventListener(MouseEvent.CLICK, onStartButtonPress);
		}
		
		private function onStartButtonPress(e:Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.ON_PRESS_START));
		}
		
	}
	
}
