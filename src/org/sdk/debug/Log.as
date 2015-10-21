package org.sdk.debug 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.getTimer;
	import org.sdk.AppWork;
	/**
	 * 打印
	 * @author Mike email:542540443@qq.com
	 */
	final public class Log 
	{
		public static var traceLevel:int = 1;
		//打印
		public static const DEBUG:int = 1;
		public static const INFO:int = 2;
		public static const WARN:int = 3;
		public static const ERROR:int = 4;
		protected static const TYPES:Array = ["##NULL##", "##DEBUG##", "##INFO##", "##WARN##", "##ERROR##"];
		//是否使用调试
		public static var isDebug:Boolean = true;
		//日志打印方和接收方的Net
		public static const LOCAL_NAME:String = "Printer";
		public static const RECV_NAME:String = "Remote";
		public static const ELIDE:String = "##self elide@";
		//发送终端的两个方法
		public static const PRINTF:String = "printf";
		public static const CLEAR:String = "clear";
		//class
		private var _connection:LocalConnection;
		private var _connectionName:String;
		private var _recvName:String;
		
		public function Log() 
		{
			this.setConnectName(RECV_NAME);
		}
		
		public function setConnectName(recvName:String):void
		{
			if (_connection) {
				try {
					_connection.close();
				}catch (err:Error) {
					
				}finally {
					_connection = null;
				}
			}
			_connectionName = LOCAL_NAME +"@time=" + getTimer() + "&ran=" + Math.random();
			trace("==Debug@提供连接外部测试：", _connectionName,"$recv:",_recvName);
			_connection = new LocalConnection;
			_connection.client = this;
			_connection.connect(_connectionName);
			_connection.addEventListener(StatusEvent.STATUS, statusHandler);
			_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncHandler);
			this.setRecvName(recvName);
		}
		
		private function statusHandler(event:StatusEvent):void
		{
			//trace(_connectionName, "-net->", _recvName, ":", event.level, event.code);
		}
		
		private function asyncHandler(event:StatusEvent):void
		{
			trace("在异步引发异常（即来自本机异步代码）时调度。");
		}
		
		public function getConnection():LocalConnection
		{
			return _connection;
		}
		
		public function get connectionName():String
		{
			return _connectionName;
		}
		
		public function setRecvName(value:String):void
		{
			_recvName = value;
		}
		
		public function get recvName():String
		{
			return _recvName;
		}
		
		//发送客户端
		public function send(methodName:String, data:*= undefined) : void
		{
			if (_recvName == null) throw Error("请设置接收端名称");
			try {
				_connection.send(_recvName, methodName, data);
			}catch (error:Error) {
				trace("LocalConnection 发送错误:", error);	
			}
		}
		
		//static *******************************
		public static function debug(...args):void 
		{	
			export(DEBUG, args);
		}
		
		public static function info(...args):void
		{
			export(INFO, args);
		}
		
		public static function warn(...args):void
		{
			export(WARN, args);
		}
		
		public static function error(...args):void
		{
			export(ERROR, args);
		}
		
		private static function export(level:int, argument:Array):void
		{
			if (traceLevel <= level) 
			{
				const header:String = TYPES[level];
				argument.unshift(header);
				trace.apply(null, argument);
			}
			Log.send(Log.PRINTF, argument);
		}
		
		public static function clear():void
		{
			Log.send(Log.CLEAR);
		} 
		
		//---自身输出函数,不包括远程打印,必定本地打印
		public static function printf(...rest):void
		{
			rest.unshift(ELIDE);
			trace.apply(null, rest);
		}
		
		private static function send(remote:String, data:*= undefined):void
		{
			if (isDebug) Log.unique.send(remote, data);
		}
		
		//打印Object
		public static function dump(data:Object):String
		{
			var chat:String = " data->";
			for (var key:String in data) {
				chat += "\nkey = " + key + ", value = " + data[key];
			}
			chat += "\n end -<";
			return chat
		}
		
		private static var _ins:Log;
		
		public static function get unique():Log
		{
			return _ins || (_ins = new Log);
		}
		//end
	}

}