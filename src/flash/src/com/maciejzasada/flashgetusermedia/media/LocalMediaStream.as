package com.maciejzasada.flashgetusermedia.media {
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.utils.Dictionary;
	/**
	 * @author magic
	 */
	public class LocalMediaStream {
		
		private static var idSeed : int = 0;
		private static var streamsById : Dictionary = new Dictionary();
		
		public var id : String;
		public var camera : Camera;
		public var microphone : Microphone;
		
		public static function getById(id : String) : LocalMediaStream {
			
			return streamsById[id];
			
		}
		
		function LocalMediaStream(camera : Camera, microphone: Microphone) {
			
			this.id = "s" + (idSeed++).toString();
			this.camera = camera;
			this.microphone = microphone;
			streamsById[this.id] = this;
			
		}
		
	}
}
