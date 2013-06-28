package com.maciejzasada.flashgetusermedia.media {
	import flash.media.SoundTransform;
	import flash.media.Camera;
	import flash.utils.Dictionary;
	/**
	 * @author magic
	 */
	public class LocalMediaStream {
		
		private static var idSeed : int = 0;
		private static var streamsById : Dictionary = new Dictionary();
		
		public var id : String;
		public var camera : Camera;
		public var microphone : MicrophoneMedia;
		
		public static function getById(id : String) : LocalMediaStream {
			
			return streamsById[id];
			
		}
		
		function LocalMediaStream(camera : Camera, microphone: MicrophoneMedia) {
			
			this.id = "s" + (idSeed++).toString();
			this.camera = camera;
			this.microphone = microphone;
			streamsById[this.id] = this;
			
			if (microphone.microphone) {
				
				microphone.microphone.setLoopBack(true);
				microphone.microphone.setSilenceLevel(0, -1);
				microphone.microphone.setUseEchoSuppression(true);
				microphone.microphone.rate = 44;
				microphone.microphone.enableVAD = true;
				microphone.microphone.encodeQuality = 10;
				microphone.microphone.soundTransform = new SoundTransform(0);
				
			}
			
		}
		
	}
}
