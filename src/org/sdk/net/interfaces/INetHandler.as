package org.sdk.net.interfaces 
{
	
	/**
	 * 处理net的方式,action是动作处理
	 * @author Mike email:542540443@qq.com
	 */
	public interface INetHandler 
	{
		function action(data:* = undefined, code:int = 0):void;
		//ends
	}
	
}