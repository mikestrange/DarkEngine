package org.sdk.debug 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.UncaughtErrorEvent;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	final public class ExceptionCapture 
	{
		
		public static function capture(root:DisplayObjectContainer):void
		{
			root.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError", uncaughtErrorHandler);
		}
		
		private static function uncaughtErrorHandler(event:UncaughtErrorEvent):void 
		{
			Log.error(event.error.getStackTrace());
		}
		
		//ends
	}

}