package com.maciejzasada.flashgetusermedia.api.getusermedia {
	/**
	 * @author magic
	 */
	public class StopRecordingHandler {
		
		public function run () : void {
			
			GetUserMediaHandler.getInstance().stopRecording();
			
		}
		
	}
}
