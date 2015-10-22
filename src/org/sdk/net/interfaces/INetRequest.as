package org.sdk.net.interfaces 
{
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public interface INetRequest 
	{
		/*
		 * 这里只是一个反馈的方式，主要可以做加密或者其他处理
		 * 2，处理完成内部直接调用net.flushPacker
		 * */
		function feedback(net:INetwork, data:Object = null):void;
		//ends
	}
	
}