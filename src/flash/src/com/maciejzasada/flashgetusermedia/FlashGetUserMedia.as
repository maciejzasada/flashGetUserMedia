package com.maciejzasada.flashgetusermedia {
	import com.maciejzasada.flashgetusermedia.utils.StageUtils;
	import flash.external.ExternalInterface;
	import flash.display.LoaderInfo;
	import com.maciejzasada.flashgetusermedia.api.Api;
	import flash.display.Sprite;

	public class FlashGetUserMedia extends Sprite {
		
		private var api : Api;
		
		public function FlashGetUserMedia() {
			
			trace("flashGetUserMedia v. 0.1");
			
			StageUtils.init(stage);
			
			api = new Api();
			api.exportJs();
			
			if (LoaderInfo(this.root.loaderInfo).parameters["initHandler"] && ExternalInterface.available) {
				
				ExternalInterface.call(LoaderInfo(this.root.loaderInfo).parameters["initHandler"]);
				
			}
			
		}
	}
}
