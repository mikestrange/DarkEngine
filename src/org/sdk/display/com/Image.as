package org.sdk.display.com 
{
	import flash.display.BitmapData;
	
	import org.sdk.display.DelegateDefined;
	import org.sdk.display.core.KindNode;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.load.DownLoader;
	import org.sdk.load.LoadEvent;
	import org.sdk.manager.member.RefObject;

	/*
	 * 不作为INode
	 * */
	public class Image extends KindNode 
	{
		private var _loader:DownLoader;
		
		public function Image(url:String = null) 
		{
			if(url) this.localRender(url);
		}
		
		/*
		 * 找不到就去下载
		 * */
		override public function getFailedHandler(name:String, data:Object = null):IRefObject 
		{
			unload();
			_loader = new DownLoader;
			_loader.load(name, onComplete, onFailed);
			return null;
		}
		
		/*
		 * 成功贴图
		 * */
		protected function onComplete(event:LoadEvent):void
		{
			this.unload();
			const url:String = event.target.getURL();
			if (hasRef(url)) {
				this.localRender(url);
			}else {
				this.washRender(new RefObject(url, event.data));
			}
			
			if(this.delegate)
			{
				this.delegate.applyHandler(DelegateDefined.IMAGE_COMPLETE,this);
			}
		}
		
		/*
		 * 失败处理
		 * */
		protected function onFailed(event:LoadEvent = null):void
		{
			this.unload();
			if(this.delegate)
			{
				this.delegate.applyHandler(DelegateDefined.IMAGE_FAILED,this);
			}
		}
		
		/*
		 * 卸载下载
		 * */
		public function unload():void
		{
			if (_loader) {
				_loader.unload();
				_loader = null;
			}
		}
		
		override public function destroy():void 
		{
			this.unload();
			super.destroy();
		}
		//end
	}

}