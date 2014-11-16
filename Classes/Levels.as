﻿package  {
	
	public class Levels {
		public static const LEVEL_VECTOR:Vector.<String> = initializeLevels();
		
		private static function initializeLevels():Vector.<String> {
			var levelVectors:Vector.<String> = new Vector.<String>();
			
			// YOLO I don't feel like doing this the file-loading way yet.  Create levels on http://ts4.us/tools/box2deditor.html,
			// click "export", then paste levels here creating new consts as appropriate.  like... const LevelX:String = "<paste here>";
			levelVectors.push(";{#rectangle, 143.5, -46, 23, 30, 0, comment, goal, 1, 0.5, 0.2, {}};{#circle, -87, -58, 9.219544457292887, 9.219544457292887, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, 5, 56, 188, 110, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -144.5, -35.5, 13, 31, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 128, -9, 101, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -122.5, -7.5, 101, 15, 0, comment, platform, 1, 0.5, 0.2, {}}");
		
			// 3 in notebook
			// stairs with lava
			levelVectors.push(";{#circle, -326, 163, 5.0990195135927845, 5.0990195135927845, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -342, 156, 10, 30, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -43, 77, 52, 5, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 88, -26.5, 48, 7, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 39.5, 46.5, 115, 139, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -181, 168, 54, 10, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 1, -163.5, 58, 129, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -145, -67.5, 32, 63, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -270.5, 15, 41, 52, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -210.5, -22, 163, 34, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -60, -113, 171, 30, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 163.5, -54.5, 133, 123, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -258, 192.5, 208, 47, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -85, 147.5, 136, 137, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -304.5, 58.5, 111, 49, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 113.5, -218, 223, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 213.5, -134.5, 33, 43, -2, comment, goal, 1, 0.5, 0.2, {}}");
		
			// need to initialize spike
			// a1 in notebook
			// player has to roll ball under spikes
			levelVectors.push(";{#rectangle, 2.5, 133.5, 193, 29, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 12.5, 177.5, 713, 19, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -256, 160, 5.0990195135927845, 5.0990195135927845, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, 312, 145, 50, 44, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -290, 150, 12, 34, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 1.5, 22.5, 233, 193, 0, comment, platform, 1, 0.5, 0.2, {}}");
		
			// two series of lava
			levelVectors.push(";{#circle, -371, 176, 6.324555320336759, 6.324555320336759, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -58, 190, 668, 16, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -246, 177.5, 178, 7, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 68.5, 177.5, 349, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 267.5, 156, 17, 52, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -385.5, 167.5, 11, 29, 0, comment, player, 1, 0.5, 0.2, {}}");
		
		
			// floating platforms
			levelVectors.push(";{#rectangle, 322, 200, 48, 38, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 114, 61.5, 162, 13, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 0.5, 203, 127, 24, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -165, -79, 208, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -361, -6, 4.47213595499958, 4.47213595499958, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -377, -17, 12, 32, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -323, 8.5, 120, 19, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 276, 230.5, 142, 21, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -277.5, -5, 29, 10, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -244, -93, 46, 8, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -92.5, -94.5, 65, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -45, 184.5, 32, 11, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 51.5, 185, 27, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 114.5, 50.5, 67, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 236, 216.5, 42, 9, 0, comment, lava, 1, 0.5, 0.2, {}}");

			// moving, floating platform
			// need to have movingPlatform, the number in comment is how far the item moves in some given time
			levelVectors.push(";{#rectangle, 196.5, -59, 89, 8, 0, 10, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 274, 60.5, 40, 45, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 94.5, 1, 93, 14, 0, 6, movingPlatform, 1, 0.5, 0.2, {}};{#circle, -333, 75, 4.123105625617661, 4.123105625617661, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -8, 83.5, 700, 7, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -25, -41, 90, 12, 0, 10, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 63.5, 74.5, 385, 11, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -348, 66, 14, 28, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -170.5, 51.5, 81, 57, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -288, 75, 46, 10, 0, comment, lava, 1, 0.5, 0.2, {}}");
		
			// falling platforms
			levelVectors.push(";{#rectangle, -13, 84.5, 700, 7, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 274, 60.5, 40, 45, 0, comment, goal, 1, 0.5, 0.2, {}};{#circle, -333, 75, 4.123105625617661, 4.123105625617661, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -348, 66, 14, 28, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -31, 78, 570, 6, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -261.5, 43, 101, 10, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -139, -15, 94, 12, 0, -100000000, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -29, -82.5, 98, 11, 0, 10, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 86, -151, 90, 12, 0, 6, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 201.5, 16.5, 69, 9, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -13, 84.5, 700, 7, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 274, 60.5, 40, 45, 0, comment, goal, 1, 0.5, 0.2, {}};{#circle, -333, 75, 4.123105625617661, 4.123105625617661, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -348, 66, 14, 28, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -31, 78, 570, 6, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -261.5, 43, 101, 10, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -139, -15, 94, 12, 0, -10, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -29, -82.5, 98, 11, 0, -10, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 86, -151, 90, 12, 0, -10, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 201.5, 16.5, 69, 9, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// "I RULE"
			levelVectors.push(";{#rectangle, 819.5, -180.5, 13, 171, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 447, -227, 39, 17, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 344.5, -193.5, 39, 17, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 174, -186, 134, 16, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 21, -102, 134, 16, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 143.5, -46, 23, 30, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -87, -58, 9.219544457292887, 9.219544457292887, 0, comment, bouncyCheckpoint, 1, 0.5, 0.2, {}};{#rectangle, 5, 56, 188, 110, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -144.5, -35.5, 13, 31, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 128, -9, 101, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -122.5, -7.5, 101, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 621.5, -135, 175, 246, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 643.5, 63.5, 371, 9, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 931, -180.5, 14, 151, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 976.5, -243.5, 65, 23, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1019, -198.5, 16, 61, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 982, -166.5, 72, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1023, -124, 16, 54, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1068, -175.5, 16, 149, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1111, -111, 84, 16, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1147.5, -176, 17, 136, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1195, -173, 12, 138, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1239.5, -109, 87, 14, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1314, -171, 14, 130, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1353, -238, 88, 14, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1346.5, -176, 79, 16, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 1350.5, -116, 81, 12, 0, comment, platform, 1, 0.5, 0.2, {}}");			
			
			return levelVectors;
		}
		
		public function Levels() {
		}

	}
	
}
