package org.sdk.load.loads 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import org.sdk.debug.Log;
	/**
	 * 图像或者SWF
	 */
	public class SwfLoader extends ResLoader 
	{
		private var loader:Loader;
		
		override public function downLoad(url:String, context:*= undefined):void 
		{
			super.downLoad(url, context);
			loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(new URLRequest(url));
		}
		
		override protected function onComplete(event:Event):void 
		{
			this.print("下载[Success]@", url, this);
			removeListeners();
			setBindData(event.target.loader as Loader);
			super.completeHandler();
		}
		
		override protected function removeListeners():void 
		{
			if (loader) {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
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