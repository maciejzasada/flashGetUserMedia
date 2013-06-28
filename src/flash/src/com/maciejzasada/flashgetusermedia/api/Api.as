package com.maciejzasada.flashgetusermedia.api {
	import com.maciejzasada.flashgetusermedia.api.getusermedia.StopRecordingHandler;
	import com.maciejzasada.flashgetusermedia.api.getusermedia.SetBufferLengthHandler;
	import com.maciejzasada.flashgetusermedia.api.getusermedia.GetUserMediaHandler;

	import flash.external.ExternalInterface;
	/**
	 * @author magic
	 */
	public class Api {
		
		private var handlers: Array = [];
		
		public function Api() {
			
			registerHandler(new GetUserMediaHandler(), "getUserMedia");
			registerHandler(new SetBufferLengthHandler(), "setBufferLength");
			registerHandler(new StopRecordingHandler(), "stopRecording");
			
		}
		
		public function exportJs() : void {
			
			for each(var handler : Object in handlers) {
				
				ExternalInterface.addCallback(handler["exportName"], handler["handler"]["run"]);
				
			}
			
		}
		
		private function registerHandler(handler: Object, exportName: String) : void {
			
			handlers.push({handler: handler, exportName: exportName});
			
		}
	}
}
