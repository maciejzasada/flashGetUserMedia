package com.maciejzasada.flashgetusermedia.api.getusermedia {
	/**
	 * @author magic
	 */
	public class SetBufferLengthHandler {
		
		public function run(bufferLength : int) : void {
			
			GetUserMediaHandler.getInstance().setBufferLength(bufferLength);
			
		}
		
	}
}
