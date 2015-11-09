package org.sdk.action 
{
	import org.sdk.interfaces.IObject;

	public interface IActionHandler extends IObject
	{
		//开始执行动作
		function play(target:Object):void;
		//下一个动作处理
		function next():IActionHandler;
		//停止动画
		function stop():void;
		//最后位置
		function finish():void;
		//ENDS
	}
	
}