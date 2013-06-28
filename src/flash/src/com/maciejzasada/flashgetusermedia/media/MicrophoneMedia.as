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
				microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			}
			
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
				
				sample = event.data.readFloat();
				inputBuffer.push(sample * 0.8);
				
			}
			
			inputData = new Vector.<Number>();
			for (var i : int = 0; i < inputBuffer.length; ++i) {
				
				inputData.push(inputBuffer[i]);
				
			}
			
			ExternalInterface.call("flashGetUserMedia.onMicrophoneSample", inputData, inputData);
			
		}
		
	}
}
