﻿package  {
	
	public class Levels {
		public static const LEVEL_VECTOR:Vector.<String> = initializeLevels();
		
		private static function initializeLevels():Vector.<String> {
			var levelVectors:Vector.<String> = new Vector.<String>();
			
			// basic starting level
			levelVectors.push(";{#rectangle, 153, -44, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#circle, -137, -29, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -159, -41, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 133, 25, 71, 96, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -133.5, 27, 71, 96, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 0.5, 46.5, 199, 55, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 0, 10, 194, 18, 0, comment, lava, 1, 0.5, 0.2, {}}");
			
			// two long sections of lava
			levelVectors.push(";{#rectangle, -53, 214.5, 658, 23, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -346, 143, 7.0710678118654755, 7.0710678118654755, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -371, 130.5, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 260, 135, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 81, 197, 312, 12, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -122, 189, 94, 28, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -342, 176.5, 78, 53, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -236, 196, 134, 12, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 257, 179, 38, 48, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// roll under spikes
			levelVectors.push(";{#circle, -340, 155, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -359, 143, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 306, 142, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -35, 130.5, 230, 23, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -32.5, 3.5, 291, 231, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -23.5, 179, 693, 32, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// slot shot
			levelVectors.push(";{#rectangle, 135, -31, 30, 40, 0, platform, goal, 1, 0.5, 0.2, {}};{#rectangle, 60.5, 83, 13, 178, 0, platform, platform, 1, 0.5, 0.2, {}};{#circle, -225, 80, 3.1622776601683795, 3.1622776601683795, 0, platform, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -292, 65.5, 20, 40, 0, platform, player, 1, 0.5, 0.2, {}};{#rectangle, -249, 93.5, 132, 13, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -73, 59, 3, 3, 0, platform, platform, 1, 0.5, 0.2, {}};{#rectangle, 58.5, -148.5, 13, 155, 0, platform, platform, 1, 0.5, 0.2, {}};{#rectangle, 110.5, 0, 121, 10, 0, platform, platform, 1, 0.5, 0.2, {}};{#rectangle, 167, -29, 14, 64, 0, platform, platform, 1, 0.5, 0.2, {}}");
			
			// stairs and pools
			levelVectors.push(";{#circle, -365, 151, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -386, 138, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 190.5, 87.5, 151, 261, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -222, 202.25, 92, 33.5, 0, comment, platform, 0, 0, 0, {}};{#rectangle, 3.5, 128.5, 59, 179, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -66, 174.5, 92, 89, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 250, -64, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 161.5, -220.75, 203, 45.5, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -7, -187.75, 132, 111.5, 0, comment, platform, 1, 0.5, 0, {}};{#rectangle, -168.5, -136.5, 193, 215, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -332, -81, 134, 324, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 73, 144, 94, 148, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -329.5, 188, 135, 60, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -143.5, 159, 77, 120, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -65, 122, 79, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -222.5, 178, 79, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 74, 63, 79, 14, 0, comment, lava, 1, 0.5, 0.2, {}}");
			
			// winding with spikes on top
			levelVectors.push(";{#rectangle, -340.5, 53.5, 75, 21, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -376.5, -197, 51, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -388, 9, 20, 268, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -92, -79, 44, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -176, -80, 44, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -5, 54, 44, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 232, -82, 44, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 262.5, -156, 17, 172, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -11, -217, 44, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 280, 182.5, 94, 23, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 105.25, -247.75, 110.5, 11.5, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -126.5, -246.5, 95, 13, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -234, -216, 44, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -290, -123, 121, 13, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -121, 103, 516, 78, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 13, -33, 516, 78, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -94, -168, 516, 78, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 180.5, 10.75, 181, 8.5, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -156.75, 12.75, 83.5, 12.5, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 30, -123, 121, 13, 0, comment, spike, 1, 0.5, 0.2, {}};{#circle, -316, -216, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -341, -228, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 288, 150, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}}");
			
			// three falling platforms
			levelVectors.push(";{#rectangle, 56, 181.5, 356, 13, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 259.5, 176, 53, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -254, 180, 88, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -49.5, 194, 675, 14, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -342, 173, 88, 28, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 271, 146, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -56, 49, 53, 26, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 40, 107, 53, 26, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 148.5, 42, 53, 26, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -166.5, 133.5, 87, 109, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -376, 139, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#circle, -353, 151, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}}");
			
			// floating platforms
			levelVectors.push(";{#rectangle, 210, 211.5, 12, 19, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 276, 230.5, 142, 21, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 171, 42, 49, 27, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 57.5, 42.5, 49, 27, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -48, 186.5, 32, 11, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 322, 200, 48, 38, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 114, 61.5, 162, 13, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 0.5, 203, 127, 24, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -165, -79, 208, 20, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -361, -6, 4.47213595499958, 4.47213595499958, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -377, -17, 12, 32, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -323, 8.5, 120, 19, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -277.5, -5, 29, 10, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -244, -93, 46, 8, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -92.5, -94.5, 65, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 51.5, 185, 27, 14, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 114.5, 50.5, 67, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 236, 216.5, 42, 9, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -172, -101.5, 98, 27, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 3, 178.5, 70, 23, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 276.5, 210, 41, 20, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// throw checkpoint into hole
			levelVectors.push(";{#circle, -226, -19, 2.8284271247461903, 2.8284271247461903, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, 124.5, 192.5, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -276, -34.5, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 290.45000000000005, 5.900000000000006, 9, 420, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -244.5, -9, 83, 12, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 96.5, 4.5, 9, 413, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 194.5, 215, 203, 6, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// going up and down tubes
			levelVectors.push(";{#rectangle, -276, -108, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 155, 158.5, 62, 15, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 96, 122.5, 48, 11, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 203, 30, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 244, -64, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 106, -130, 62, 15, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 43, 79, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -4, 20, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 40, -76, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -4, -161, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -298.75, -141.75, 61.5, 13.5, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -213, -120, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -162, -54, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -159, 85, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -213, 14, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -21, 167, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -242, 172, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 179, 140, 78, 16, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 216, 209, 128, 11, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 11, 216, 128, 11, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -191, 228.5, 128, 11, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -276, 2, 62, 14, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -300, 130, 62, 14, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -5, 146, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -307, 35.5, 46, 13, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -242, -49, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -334, -248, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -335, -191, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 96, 9, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 146, -109, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -103, 22, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, -64, -100, 52, 12, 0, comment, spike, 1, 0.5, 0.2, {}};{#rectangle, 194, -233, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 210, -205, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -218, 154, 62, 15, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 140, -17, 62, 15, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -96, 138, 62, 15, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -68, -7, 62, 15, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -95, -125, 62, 15, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -334, 46, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -131, 39, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -33, -50, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 70, 23, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 275, 15, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 174, -63, 8, 392, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			// falling platforms that rise and then fall sharply
			levelVectors.push(";{#rectangle, 288, 61, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -352, 60, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, 5, -102, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -89, -58, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -187, -14, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -282.5, 30, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -13, 84.5, 700, 7, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -333, 75, 4.123105625617661, 4.123105625617661, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -31, 78, 570, 6, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 118, 51, 63, 12, 0, comment, movingPlatform, 1, 0.5, 0.2, {}}");
			
			// tricky level :O
			levelVectors.push(";{#rectangle, 153, -191, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 51, -202, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -37, -203, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -121, -203, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -205, -202, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 242, -155, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 174, -118, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 104, -80, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 39, -39, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 179, 230, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 180.5, 264.5, 129, 29, 0, comment, platform, 1, 0.5, 0.2, {}};{#circle, -304, 16, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -326, 3, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -203.5, 42, 267, 38, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -28, 1.5, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -293, -201, 64, 25, 0, comment, movingPlatform, 1, 0.5, 0.2, {}}");
				
			// lots and lots of lavaaaaa
			levelVectors.push(";{#rectangle, 290, 98, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 118, 168, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 204, 138, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 156, 44, 121, 17, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -56, -33, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -132, -81, 121, 17, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 50, 9, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -200, -184, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -34, -230, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -310, 68, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 0, -120, 121, 17, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, 14, 86, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -134, 132, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -301.5, 220, 145, 24, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -332, 188, 20, 40, 0, comment, player, 1, 0.5, 0.2, {}};{#circle, -301, 201, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, 92, -197, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, 74, -168, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, -224, -20, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 13, 198, 121, 17, 0, comment, movingPlatform, 1, 0.5, 0.2, {}};{#rectangle, 159.5, -75, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -126, 21, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, -294, -78, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 209, -120, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}};{#rectangle, 205, -221, 85, 18, 0, comment, lava, 1, 0.5, 0.2, {}}");
		
			// win
			levelVectors.push(";{#circle, -100, 15, 7, 7, 0, comment, checkpoint, 1, 0.5, 0.2, {}};{#rectangle, -157, -144, 30, 60, 0, comment, player, 1, 0.5, 0.2, {}};{#rectangle, -145.5, 164.5, 51, 3, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -139, 144, 30, 40, 0, comment, goal, 1, 0.5, 0.2, {}};{#rectangle, -208.5, 83.5, 17, 165, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -252, 28, 17, 278, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -74, 146, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -152, -94, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -335, 123, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -323, 112, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -309, 101, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -297, 110, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -286, 123, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -276, 138, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -265, 145, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -360, 144, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -56, 24, 17, 278, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -162, 26, 17, 278, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -371.5, 23, 17, 278, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -345, 136, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -142, -69, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -134, -46, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -127, -26, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -119, -6, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -114, 15, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -107, 40, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -102, 62, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -97, 84, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -90, 104, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}};{#rectangle, -81, 129, 18, 36, 0, comment, platform, 1, 0.5, 0.2, {}}");
			
			return levelVectors;
		}
		
		public function Levels() {
		}

	}
	
}
