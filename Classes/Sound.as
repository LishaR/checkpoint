package  {
	
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.events.Event;
	
	public class Sound {
		
		public static const MUSIC:int = 1;
		
		private static const NUM_SONGS:int = 1;
		private static const music:Music = new Music();
		
		public static function play(sound:int) {
			if (sound == MUSIC) {
				music.play(0, 9999);
			} 
		}
		
	}
	
}
