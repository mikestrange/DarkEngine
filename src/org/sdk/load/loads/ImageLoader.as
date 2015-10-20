package org.sdk.load.loads 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	/**
	 *图片下载器
	 */
	public class ImageLoader extends SwfLoader 
	{
		
		override protected function onComplete(event:Event):void 
		{
			const loader:Loader = event.target.loader as Loader;
			if (loader.content == null) {
				onError(new IOErrorEvent("", false, false, "请检查路径是否合法", 404));
			}else {
				this.print("下载[Success]@", url, this);
				removeListeners();
				//这个时候资源下载错误
				const bit:BitmapData = loader.content["bitmapData"] as BitmapData;
				loader.unload();
				setBindData(bit);
				super.completeHandler();
			}
		}
		//ends
	}

}