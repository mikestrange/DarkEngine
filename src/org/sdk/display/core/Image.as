package org.sdk.display.core 
{
	import flash.display.BitmapData;
	import org.sdk.load.DownLoader;
	import org.sdk.load.LoadEvent;
	import org.sdk.reuse.RefObject;
	/*
	 * 不作为INode
	 * */
	public class Image extends InternalRender 
	{
		private var _loader:DownLoader;
		
		public function Image(url:String = null) 
		{
			if(url) setResource(url);
		}
		
		public function setResource(url:String, data:Object = null):void 
		{
			if (hasRef(url)) {
				this.localRender(url, data);
			}else{
				unload();
				_loader = new DownLoader;
				_loader.load(url, onComplete, onFailed);
			}
		}
		
		protected function onComplete(event:LoadEvent):void
		{
			this.unload();
			const url:String = event.target.getURL();
			if (!hasRef(url)) {
				this.washRender(new RefObject(url, event.data));
			}else {
				this.localRender(url);
			}
		}
		
		protected function onFailed(event:LoadEvent = null):void
		{
			this.unload();
		}
		
		public function unload():void
		{
			if (_loader) {
				_loader.unload();
				_loader = null;
			}
		}
		
		override public function undepute():void 
		{
			this.unload();
			super.undepute();
		}
		//end
	}

}