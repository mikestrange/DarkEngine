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
		private var _handler:Function;
		private var _data:*= undefined;
		private var _args:*= undefined;
		
		public function HttpHandler(url:String, handler:Function = null, args:* = undefined) 
		{
			_url = url;
			_handler = handler;
			_args = args;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set result(value:*):void
		{
			_data = value;
		}
		
		public function get result():*
		{
			return _data;
		}
		
		public function get args():*
		{
			return _args;
		}
		
		/* INTERFACE org.sdk.net.interfaces.INetHandler */
		public function action():void 
		{
			if (_handler is Function)
			{
				_handler(this);
			}
		}
		
		//ends
	}

}