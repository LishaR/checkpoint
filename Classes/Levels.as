package  {
	
	public class Levels {
		public static const LEVEL_VECTOR:Vector.<String> = initializeLevels();
		
		private static function initializeLevels():Vector.<String> {
			var levelVectors:Vector.<String> = new Vector.<String>();
			
			// two long sections of lava
			levelVectors.push(";{#rectangle, -53, 214.5, 658, 23, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -346, 143, 7.0710678118654755, 7.0710678118654755, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -371, 130.5, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 260, 135, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 81, 197, 312, 12, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -122, 189, 94, 28, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -342, 176.5, 78, 53, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -236, 196, 134, 12, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 257, 179, 38, 48, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// roll under spikes
			levelVectors.push(";{#circle, -340, 155, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -359, 143, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 306, 142, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -35, 130.5, 230, 23, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -32.5, 3.5, 291, 231, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -23.5, 179, 693, 32, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// stairs and pools
			levelVectors.push(";{#circle, -365, 151, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -386, 138, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 190.5, 87.5, 151, 261, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -222, 202.25, 92, 33.5, 0, comment, platform,, NaN, NaN, NaN, {}};{#rectangle, 3.5, 128.5, 59, 179, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -66, 174.5, 92, 89, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 250, -64, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 161.5, -220.75, 203, 45.5, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -7, -187.75, 132, 111.5, 0, comment, platform, 1, 0.5, NaN, {}};{#rectangle, -168.5, -136.5, 193, 215, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -332, -81, 134, 324, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 73, 144, 94, 148, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -329.5, 188, 135, 60, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -143.5, 159, 77, 120, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -65, 122, 79, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -222.5, 178, 79, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 74, 63, 79, 14, 0, comment, lava, 1, 0.5, 0.2, {}}");
			
			// jumping between platforms with pools
			levelVectors.push(";{#circle, -325, 21, 7, 7, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -346, 9, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 76, 145.5, 142, 13, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 183.75, 51.5, 128.5, 11, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -46.25, -49.75, 158.5, 11.5, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -289, 56.5, 134, 13, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 370, 141, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 332.5, 173.5, 109, 25, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 77, 126.75, 42, 25.5, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 229, 33.25, 36, 26.5, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 140, 33.25, 42, 26.5, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 8.75, -60.5, 46.5, 9, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, -46, -69, 62, 24, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -314, 39.5, 84, 21, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -246, 45, 49, 10, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, -101, -62, 49, 10, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, 186, 41, 49, 10, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, 31, 134, 49, 10, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, 122.25, 133, 48.5, 10, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 261.5, 181.5, 33, 9, 0, comment, pool, 1, 0.5, 0.2, {}}");
			
			// three falling platforms
			levelVectors.push(";{#rectangle, 271, 146, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -56, 49, 53, 26, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 40, 107, 53, 26, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 148.5, 42, 53, 26, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -253.5, 181, 91, 12, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, -166.5, 133.5, 87, 109, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 55.5, 181, 357, 14, 0, comment, pool, 1, 0.5, 0.2, {}};{#rectangle, -376, 139, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#circle, -353, 151, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -343, 173, 88, 28, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -49.5, 194, 675, 14, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 259.5, 176, 53, 20, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// floating platforms
			levelVectors.push(";{#rectangle, 322, 200, 48, 38, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 114, 61.5, 162, 13, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 0.5, 203, 127, 24, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -165, -79, 208, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -361, -6, 4.47213595499958, 4.47213595499958, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -377, -17, 12, 32, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -323, 8.5, 120, 19, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 276, 230.5, 142, 21, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -277.5, -5, 29, 10, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -244, -93, 46, 8, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -92.5, -94.5, 65, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -45, 184.5, 32, 11, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 51.5, 185, 27, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 114.5, 50.5, 67, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 236, 216.5, 42, 9, 0, comment, lava, 1, 0.5, 0.2, {}}");
		
			// falling platforms that rise and then fall sharply
			levelVectors.push(";{#rectangle, 288, 61, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -352, 60, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 5, -102, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -89, -58, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -187, -14, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -282.5, 30, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -13, 84.5, 700, 7, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -333, 75, 4.123105625617661, 4.123105625617661, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -31, 78, 570, 6, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 118, 51, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}}");
			return levelVectors;
		}
		
		public function Levels() {
		}

	}
	
}
