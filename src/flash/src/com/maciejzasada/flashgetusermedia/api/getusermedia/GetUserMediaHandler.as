package com.maciejzasada.flashgetusermedia.api.getusermedia {
	import com.maciejzasada.flashgetusermedia.media.LocalMediaStream;
	import com.maciejzasada.flashgetusermedia.utils.JsUtils;
	import com.maciejzasada.flashgetusermedia.utils.StageUtils;

	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.system.SecurityPanel;

	/**
	 * @author magic
	 */
	public class GetUserMediaHandler {
		
		private var camera : Camera;
		private var microphone: Microphone;
		
		public function GetUserMediaHandler() {
			
		}
		
		public function run(options: Object) : void {
			
			if (options) {
				if (options["video"]) {
					startVideo();
				}
				if (options["audio"]) {
					startAudio();
				}
			}
			
		}
		
		private function startVideo() : void {
			
			camera = Camera.getCamera();
			
			if (camera.muted) {
				
				JsUtils.maximize();
				Security.showSettings(SecurityPanel.PRIVACY);
				StageUtils.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			} else {
				
				onSecurityPanelClose();
				
			}
			
		}
		
		private function startAudio() : void {
			
			microphone = Microphone.getMicrophone();
			
			if (microphone.muted) {
				
				JsUtils.maximize();
				Security.showSettings(SecurityPanel.PRIVACY);
				StageUtils.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			} else {
				
				onSecurityPanelClose();
				
			}
			
		}
		
		private function onEnterFrame(event : Event) : void {
			
			var dummy : BitmapData = new BitmapData(1, 1);
			
			try {
    			dummy.draw(StageUtils.stage);
				StageUtils.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				onSecurityPanelClose();
			} catch (error:Error) {
				
			}
			
		}
		
		private function onSecurityPanelClose() : void {
			
			onMediaStatus(camera && !camera.muted ? true : false, microphone && !microphone.muted ? true : false);
			
		}
		
		private function onMediaStatus(cameraAllowed: Boolean, microphoneAllowed: Boolean) : void {
			
			ExternalInterface.call("flashGetUserMedia.onMediaStatus", cameraAllowed, microphoneAllowed, new LocalMediaStream(cameraAllowed ? camera : null, microphoneAllowed ? microphone : null));
			
		}
		
	}
}
