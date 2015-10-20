package org.sdk.action 
{
	public interface IAction
	{
		//执行动作
		function execute(target:Object, refer:Object, runtime:Number = 1):void;
		//停止动作，是否到达最终，是否调用结束函数
		function stopAction(toend:Boolean = false, iscomplete:Boolean = false):void;
		//销毁的时候清理值
		function cleanAndStop():void; 
		//ENDS
	}
	
}