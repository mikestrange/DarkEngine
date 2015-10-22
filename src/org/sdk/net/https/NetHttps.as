package org.sdk.net.https 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import org.sdk.interfaces.DelegateObject;
	import org.sdk.net.interfaces.INetHandler;
	import org.sdk.net.interfaces.INetRequest;
	import org.sdk.net.interfaces.INetwork;
	
	public class NetHttps extends DelegateObject implements INetwork 
	{
		public static const _ZERO_:int = 0;
		//
		private var isOver:Boolean;
		private var loader:URLLoader;
		private var serverUrl:String;
		private var handList:Vector.<INetHandler>;
		
		public function NetHttps(server:String = null) 
		{
			if (server) {
				serverUrl = server;
			}
			initialize();
		}
		
		public function getAddress():String
		{
			return serverUrl;
		}
		
		public function close():void
		{
			try{
				loader.close();
			}catch (e:Error) {
				trace('http未开始请求的断开');
			}finally {
				while (handList.length) {
					handList.shift();
				}
			}
		}
		
		protected function initialize():void 
		{
			handList = new Vector.<INetHandler>;
			isOver = true;
			loader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
		}
		
		protected function onErrorHandler(e:IOErrorEvent):void
		{
			const result:HttpHandler = handList.shift();
			trace("Error for Http 404:请确保连接上了后台,未知端口！ url:" + result.url);
			sendNext();
			result.action();
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			trace("->回执数据是:" + event.target.data);
			//com.adobe.serialization.json.JSON.decode(e.target.data as String);
			const result:HttpHandler = handList.shift();
			result.result = event.target.data;
			sendNext();
			//处理
			result.action();
		}
		
		/* INTERFACE org.web.sdk.net.interfaces.INetwork */
		public function sendRequest(request:INetRequest, data:Object = null):void
		{
			//头处理
			if (request) request.feedback(this, data);
			//发送
			var url:String = getAddress();
			if (url.indexOf("?") == -1) url += "?";
			//send
			if (data)
			{
				var called:Function;
				var args:*;
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
				called = data["complete"];
				args = data["args"];
				this.flushPacker(new HttpHandler(url, called, args));
			}
		}
		
		/*
		 * 真正发送的地方
		 * */
		public function flushPacker(data:*= undefined):void
		{
			handList.push(data as INetHandler);
			if (!isOver) {
				sendNext();
			}
		}
		
		protected function sendNext():void
		{
			if (handList.length) {
				isOver = true;
				const result:HttpHandler = handList[_ZERO_] as HttpHandler;
				const request:URLRequest = new URLRequest(result.url);
				//request.data = data;
				request.method = URLRequestMethod.GET;
				loader.load(request);
			}else {
				isOver = false;
			}
		}
		
		//删除所有
		public function remove(url:String):void
		{
			if (handList.length) {
				//当前不会被删除
				for (var i:int = handList.length - 1; i > _ZERO_; i--) 
				{
					const result:HttpHandler = handList[i] as HttpHandler;
					if (result.url == url) 
					{
						handList.splice(i, 1);
					}
				}
			}
		}
		
		//ends
	}

}