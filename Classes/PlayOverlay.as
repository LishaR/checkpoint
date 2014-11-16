package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import fl.text.TLFTextField;
	
	public class PlayOverlay  extends MovieClip {

		private var playScreen:PlayScreen;
		
		public var numCheckpoints:TLFTextField;

		public function PlayOverlay(ps:PlayScreen) {
			playScreen = ps;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			leftButton.addEventListener(TouchEvent.TOUCH_BEGIN, playScreen.onLeftButtonPress);
			rightButton.addEventListener(TouchEvent.TOUCH_BEGIN, playScreen.onRightButtonPress);
			jumpButton.addEventListener(TouchEvent.TOUCH_BEGIN, playScreen.onJumpButtonPress);
			leftButton.addEventListener(TouchEvent.TOUCH_END, playScreen.onLeftButtonRelease);
			rightButton.addEventListener(TouchEvent.TOUCH_END, playScreen.onRightButtonRelease);
			
			leftButton.x = 0;
			leftButton.y = stage.stageHeight - leftButton.height;
			rightButton.x = leftButton.width;
			rightButton.y = stage.stageHeight - rightButton.height;
			jumpButton.x = stage.stageWidth - jumpButton.width;
			jumpButton.y = stage.stageHeight - jumpButton.height;
		}

	}
	
}
