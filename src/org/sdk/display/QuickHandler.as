package org.sdk.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import org.sdk.debug.Log;
	import org.sdk.interfaces.IObject;
	/**
	 * 快速处理
	 */
	public class QuickHandler 
	{
		private static const NONE:int = 0;
		
		//释放元素子集
		public static function cleanupDisplayObject(dispaly:DisplayObject, value:Boolean = false):void
		{
			if (null == dispaly) return;
			if (value) {
				if (dispaly is IObject) {
					IObject(dispaly).destroy();
				}else if (dispaly is Bitmap) {
					cleanupBitmap(dispaly as Bitmap);
				}else if (dispaly is Loader) {
					cleanupLoader(dispaly as Loader);
				}else if (dispaly is MovieClip) {
					MovieClip(dispaly).stop();
					return;
				}
			}
			if (dispaly is DisplayObjectContainer) {
				const target:DisplayObjectContainer = dispaly as DisplayObjectContainer;
				while (target.numChildren) {
					cleanupDisplayObject(target.removeChildAt(0), true);
				}
			}
		}
		
		public static function cleanupLoader(loader:Loader):void
		{
			if (loader) {
				loader.unloadAndStop();
			}
		}
		
		public static function cleanupBitmap(bitmap:Bitmap):void
		{
			if (bitmap == null) return;
			cleanupBitmapdata(bitmap.bitmapData);
			bitmap.bitmapData = null;
		}
		
		public static function cleanupBitmapdata(bit:BitmapData):void
		{
			if (bit && bit.width + bit.height > NONE) {
				bit.dispose();
			}
		}
		
		public static function collection():void
        {
			try {
				var connent1:LocalConnection =  new LocalConnection();
				connent1.connect("cleanMemory");
				var connent2:LocalConnection =  new LocalConnection();
				connent2.connect("cleanMemory");
			}catch (e:Error) {
				Log.printf('#Error:强制清理');
			}
        }
		//ends
	}

}