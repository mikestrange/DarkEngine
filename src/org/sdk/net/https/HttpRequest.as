package org.sdk.net.https
{
	import org.sdk.net.interfaces.INetRequest;
	import org.sdk.net.interfaces.INetwork;
	
	public class HttpRequest implements INetRequest
	{
		private var _rootUrl:String;
		private var _called:Function;
		private var _args:*;
		
		public function HttpRequest(rootUrl:String, called:Function = null, args:* = undefined)
		{
			this._rootUrl = rootUrl;
			this._called = called;
			this._args = args;
		}
		
		public function get args():*
		{
			return _args;
		}
		
		public function getAddress():String
		{
			return _rootUrl;
		}
		
		//这里只是一种协议的处理
		public function feedback(net:INetwork, data:Object=null):void
		{
			var url:String = getAddress();
			//send
			if (data)
			{
				if (url.indexOf("?") == -1) url += "?";
				var key:*;
				var item:*;
				for (key in data)
				{
					item = data[key];
					if (null != item && undefined != item && (item is Number || item is String || item is Boolean))
					{
						url += (item is Number && isNaN(item))?("&" + key + "=0"):("&" + key + "=" + item);
					}
				}
			}
			//
			net.flushPacker(new HttpHandler(url, _called, _args));
		}
		
		//ends
	}
}