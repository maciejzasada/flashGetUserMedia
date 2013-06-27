package com.maciejzasada.flashgetusermedia.utils {
	import flash.external.ExternalInterface;
	/**
	 * @author magic
	 */
	public class JsUtils {
		
		public static function maximize() : void {
			
			ExternalInterface.call("flashGetUserMedia.maximize");
			
		}
		
		public static function minimize() : void {
			
			ExternalInterface.call("flashGetUserMedia.minimize");
			
		}
		
	}
}
