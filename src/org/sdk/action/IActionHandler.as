package org.sdk.action 
{
	import org.sdk.interfaces.IObject;

	public interface IActionHandler extends IObject
	{
		//开始执行动作
		function play(target:Object,...rest):void;
		//下一个动作处理(如果停止，那么下一个动画将不会执行，直接进行动画的当前结案)
		function next():IActionHandler;
		//停止动画
		function stop():void;
		//最后位置()
		function finish():void;
		//这个是由传入者更改
		function getActionName():String;
		//ENDS
	}
}