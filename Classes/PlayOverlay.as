package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PlayOverlay  extends MovieClip {

		private var playScreen:PlayScreen;

		public function PlayOverlay(ps:PlayScreen) {
			playScreen = ps;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			leftButton.addEventListener(MouseEvent.MOUSE_DOWN, playScreen.onLeftButtonPress);
			rightButton.addEventListener(MouseEvent.MOUSE_DOWN, playScreen.onRightButtonPress);
			jumpButton.addEventListener(MouseEvent.MOUSE_DOWN, playScreen.onJumpButtonPress);
			
			leftButton.x = 0;
			leftButton.y = stage.stageHeight - leftButton.height;
			rightButton.x = leftButton.width;
			rightButton.y = stage.stageHeight - rightButton.height;
			jumpButton.x = stage.stageWidth - jumpButton.width;
			jumpButton.y = stage.stageHeight - jumpButton.height;
		}

	}
	
}
