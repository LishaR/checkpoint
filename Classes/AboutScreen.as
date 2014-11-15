package  {
	
	import flash.display.MovieClip;
	
	public class AboutScreen extends MovieClip {

		public function AboutScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			backButton.addEventListener(MouseEvent.CLICK, onBackButtonPress);
		}
		
		private function onBackButtonPress(e:Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.ON_PRESS_ABOUT_BACK));
		}

	}
	
}
