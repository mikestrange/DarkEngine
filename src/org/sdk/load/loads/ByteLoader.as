package org.sdk.load.loads 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * 二进制文件读取
	 */
	public class ByteLoader extends ResLoader 
	{
		private var loader:URLStream;
		
		override public function downLoad(url:String, context:*= undefined):void 
		{
			super.downLoad(url, context);
			loader = new URLStream;
			loader.endian = Endian.BIG_ENDIAN;
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
			var target:URLStream = event.target as URLStream;
			var byte:ByteArray = new ByteArray;
			byte.endian = target.endian;
			target.readBytes(byte, 0, target.bytesAvailable);
			setBindData(byte);
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
		//ENDS
	}

}