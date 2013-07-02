package com.maciejzasada.flashgetusermedia.media {
	import flash.events.SampleDataEvent;
	import flash.external.ExternalInterface;
	import flash.media.Microphone;
	/**
	 * @author magic
	 */
	public class MicrophoneMedia {
		
		public var microphone : Microphone;
		private var bufferLength : int = 1024;
		private var processing : Boolean = false;
		private var inputBuffer : Vector.<Number>;
		private var inputData : Vector.<Number>;
		private var currentIndex : int = 0;
		private var sample : Number;
		
		function MicrophoneMedia(microphone : Microphone) {
			
			this.microphone = microphone;
			if(microphone) {
				this.microphone.rate = 44;
				microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			}
			
			ExternalInterface.call("console.log", "mic rate: " + microphone.rate.toString());
		}
		
		public function get rate() : int {
			
			return microphone.rate;
			
		}
		
		public function setBufferLength(length : int) : void {

			trace("setting buffer length", length);
			bufferLength = length;
			
		}
		
		public function startProcessing() : void {
			
			microphone.setLoopBack(true);
			processing = true;
			
		}
		
		public function stopProcessing() : void {
			
			microphone.setLoopBack(false);
			processing = false;
			
		}
		
		private function onSampleData(event : SampleDataEvent) : void {
			
			inputBuffer = new Vector.<Number>();
			currentIndex = 0;
			
			while (event.data.bytesAvailable > 0 && currentIndex ++ < bufferLength) {
				
				sample = Number(event.data.readFloat());
				inputBuffer.push(sample * 0.8);
				
			}
			
			var increment : Number = 44.0 / microphone.rate;
			
			inputData = new Vector.<Number>();
			for (var i : Number = 0; i < inputBuffer.length; i += increment) {
				
				inputData.push(inputBuffer[Math.round(i)]);
				
			}
			
			ExternalInterface.call("flashGetUserMedia.onMicrophoneSample", inputData, inputData);
			
		}
		
	}
}
