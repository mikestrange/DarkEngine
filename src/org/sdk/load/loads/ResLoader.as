package org.sdk.load.loads 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import org.sdk.debug.Log;
	import org.sdk.load.IResLoader;
	import org.sdk.load.QueueManager;
	
	/**
	 * 资源下载的基类
	 */
	public class ResLoader implements IResLoader 
	{
		private var _data:*;
		private var _url:String;
		protected var _isError:Boolean;
		protected var _context:*;
		
		/* INTERFACE org.sdk.load.IResLoader */
		public function get isError():Boolean
		{
			return _isError;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function downLoad(url:String, context:*= undefined):void 
		{
			_url = url;
			_context = context;
		}
		
		public function finalize():void 
		{
			
		}
		
		protected function setBindData(value:*):void
		{
			_data = value;
		}
		
		protected function removeListeners():void
		{
			
		}
		
		//Http结果
		protected function onHttpStatus(event:HTTPStatusEvent):void
		{
			print("下载[httpStatus=" + event.status + "]@", url);
		}
		
		//成功
		protected function onComplete(event:Event):void
		{
			print("下载[Success]@", url);
		}
		
		//错误
		protected function onError(event:IOErrorEvent):void
		{
			print("下载[Error]@", url, "->errorId:", event.errorID, ", exp =",event.text);
			this.removeListeners();
			this._isError = true;
			completeHandler();
		}
		
		//沙箱
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			print("下载[onSecurityError]@", url, "->print:", event);
		}
		
		//进度
		protected function onProgress(event:ProgressEvent):void
		{
			QueueManager.unique.onProgressHandler(_url, event);
		}
		
		protected function completeHandler():void
		{
			QueueManager.unique.onLoadComplete(this);
		}
		
		//打印
		protected function print(...rest):void
		{
			Log.debug.apply(null, rest);
		}
		//ends
	}

}