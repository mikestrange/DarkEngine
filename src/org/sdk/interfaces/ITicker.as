package org.sdk.interfaces 
{
	
	/**
	 * ...计时器,闹钟
	 * @author Mike email:542540443@qq.com
	 */
	public interface ITicker 
	{
		/*
		 * 最少也有一帧的间隔
		 * */
		function step(delay:Number, method:Function, time:int = 1, ...rest):void;
		/*
		 * 会删除同一个函数的所有监听
		 * */
		function kill(method:Function):void;
		//end
	}
	
}