package org.sdk.net.https
{
	import org.sdk.net.interfaces.INetRequest;
	import org.sdk.net.interfaces.INetwork;
	
	public class HttpRequest implements INetRequest
	{
		private var _url:String;
		
		public function HttpRequest(url:String)
		{
			this._url = url;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		//这里只是一种协议的封装过程
		public function feedback(net:INetwork, data:Object=null):void
		{
			//这里最终要的只是［HttpHandler］
			if(data)
			{
				net.flushPacker(new HttpRespond(url, data["onComplete"], data["args"]));
			}else{
				net.flushPacker(new HttpRespond(url));
			}	
		}
		
		//static转换
		public static function getURLByObject(rootUrl:String, data:Object = null):String
		{
			var file:String = rootUrl;
			//send
			if (data)
			{
				if (file.indexOf("?") == -1) file += "?";
				var key:*;
				var item:*;
				for (key in data)
				{
					item = data[key];
					if (null != item && undefined != item && (item is Number || item is String || item is Boolean))
					{
						file += (item is Number && isNaN(item))?("&" + key + "=0"):("&" + key + "=" + item);
					}
				}
			}
			return file;
		}
		//ends
	}
}