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
		private var handList:Vector.<INetHandler>;
		
		public function NetHttps() 
		{
			initialize();
		}
		
		public function close():void
		{
			try{
				loader.close();
			}catch (e:Error) {
				trace('http未开始请求的断开');
			}finally {
				isOver = true;
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
			nextHandler();
			result.action();
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			trace("-<<recv https:" + event.target.data);
			//com.adobe.serialization.json.JSON.decode(e.target.data as String);
			const result:HttpHandler = handList.shift();
			result.result = event.target.data;
			nextHandler();
			//处理
			result.action();
		}
		
		/* INTERFACE org.web.sdk.net.interfaces.INetwork */
		public function sendRequest(request:INetRequest, data:Object = null):void
		{
			if (request){
				request.feedback(this, data);
			}
		}
		
		/*
		 * 真正发送的地方 INetHandler
		 * */
		public function flushPacker(data:*= undefined):void
		{
			handList.push(data as INetHandler);
			if (isOver) nextHandler();
		}
		
		//处理下一个
		protected function nextHandler():void
		{
			if (handList.length) {
				isOver = false;
				const result:HttpHandler = handList[_ZERO_] as HttpHandler;
				const request:URLRequest = new URLRequest(result.url);
				//request.data = data;
				request.method = URLRequestMethod.GET;
				loader.load(request);
				trace("->>send https:",result.url);
			}else {
				isOver = true;
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