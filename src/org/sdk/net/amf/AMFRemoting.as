package org.sdk.net.amf
{
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	/**
	 * AMF协议
	 * @author Mike email:542540443@qq.com
	 */
	public class AMFRemoting extends NetConnection
	{
		private var _responder:Responder;
		
		public function get responder():Responder
		{
			return _responder;
		}
		
		//连接远程服务
		public function connectRemote(gateway:String, amfType:uint = ObjectEncoding.AMF3):void
		{
			if (this.connected) return;
			if (null == _responder) {
				_responder = new Responder(onResultHandler, onFaultHandler);
			}
			this.objectEncoding = amfType;
			if (!this.hasEventListener(NetStatusEvent.NET_STATUS)) {
				this.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			}
			if (!this.hasEventListener(SecurityErrorEvent.SECURITY_ERROR)) {
				this.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			}
			try {
				this.connect(gateway);
			}catch (err:Error) {
				trace("连接AMF错误：", err);
			}
		}
		
		protected function netStatusHandler(event:NetStatusEvent):void
		{
			const code:String = event.info.code;
			switch(code)
			{
				case "NetConnection.Call.BadVersion":
					trace("版本错误或者回传的数据有问题");
					break;
				case "NetConnection.Call.Failed ":
					trace("找不到远程接口或者API路径错误");
					break;
				default:
					trace("Amf code:", code);
					break;
			}
		}
		
		protected function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("网络错误 AMF Remoting 连接错误:", event);
		}
		
		//发送远程
		public function sendRemoting(remoteMethod:String, ...args):void
		{
			args.unshift(remoteMethod);
			args.unshift(responder);
			this.call.apply(this, args);
		}
		
		//回执 调用全局消息,可以通过CMD调用
		protected function onResultHandler(response:Object):void
		{
			for (var key:String in response) 
			{
				trace(key,response[key])
			}
			trace('AMF Server return Client: ' + response);
		}
		
		//错误处理
		protected function onFaultHandler(response:Object = null):void
		{
			trace('AMF Server return Error:', response);
		}
		
		public function destroy():void 
		{
			if (this.connected) {
				this.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				this.close();
			}
		}
		
		//*********************test****************
		public static function test():void
		{
			var amf:AMFRemoting = new AMFRemoting;
			amf.connectRemote("http://localhost:80/amfphp-2.2.1/Amfphp/index.php");
			amf.sendRemoting('LogicService.logic');
		}
		//ends
	}

}