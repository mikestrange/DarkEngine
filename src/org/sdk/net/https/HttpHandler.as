package org.sdk.net.https 
{
	import org.sdk.net.interfaces.INetHandler;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class HttpHandler implements INetHandler 
	{
		private var _url:String;
		private var _status:int = 0;
		private var _handler:Function;
		private var _data:*= undefined;
		private var _args:*= undefined;
		
		public function HttpHandler(url:String, handler:Function = null, args:* = undefined) 
		{
			_url = url;
			_handler = handler;
			_args = args;
		}
		
		public function get handler():Function
		{
			return _handler;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get args():*
		{
			return _args;
		}
		
		public function get result():*
		{
			return _data;
		}
				
		public function set result(value:*):void
		{
			_data = value;
		}
		
		public function get status():int
		{
			return _status;
		}
		
		public function set status(value:int):void
		{
			_status = value;
		}
		
		public function free():void
		{
			_handler = null;
		}
		
		/* INTERFACE org.sdk.net.interfaces.INetHandler */
		public function action():void 
		{
			//如果数据太复杂，建议this＝MessageVo
			if (_handler is Function)
			{
				_handler(this); 
			}
		}
		
		//ends
	}

}