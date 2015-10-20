package org.sdk.net.interfaces 
{
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public interface INet 
	{
		/*
		 * 代理发送
		 * */
		function sendRequest(request:INetRequest, data:Object = null):void;
		/*
		 * 真正发送的地方
		 * */
		function flushPacker(data:*= undefined):void; 
		/*
		 * 关闭，中断
		 * */
		function close():void;
		/*
		 * 回执处理的函数
		 * */
		function set respondHandler(value:Function):void;
		//ends
	}
	
}