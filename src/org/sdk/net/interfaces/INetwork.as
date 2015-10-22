package org.sdk.net.interfaces 
{
	import org.sdk.interfaces.IObject;
	/**
	 * 网络基类
	 * @author Mike email:542540443@qq.com
	 */
	public interface INetwork extends IObject
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
		//ends
	}
	
}