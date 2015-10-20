package org.sdk.load.loads 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	/**
	 * 文本资源下载
	 */
	public class TextLoader extends ResLoader 
	{
		private var loader:URLLoader;
		
		override public function downLoad(url:String, context:*= undefined):void 
		{
			super.downLoad(url, context);
			loader = new URLLoader;
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			loader.load(new URLRequest(url));
		}
		
		override protected function onComplete(event:Event):void 
		{
			super.onComplete(event);
			removeListeners();
			setBindData(URLLoader(event.target).data);
			super.completeHandler();
		}
		
		override protected function removeListeners():void 
		{
			if (loader) {
				loader.removeEventListener(Event.COMPLETE, onComplete);
				loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				loader = null;
			}
		}
		
		override public function finalize():void 
		{
			if (loader) {
				try {
					loader.close();
				}catch (e:Error) {
					print("下载未开始或者未完成:", url);
				}
				removeListeners();
			}
		}
		//ends
	}

}