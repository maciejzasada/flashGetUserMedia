package com.maciejzasada.flashgetusermedia.utils {
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Stage;
	/**
	 * @author magic
	 */
	public class StageUtils {
		
		public static var stage : Stage;
		
		public static function init(stage : Stage) : void {
			
			StageUtils.stage = stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 60;
			
		}
		
	}
}
