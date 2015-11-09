package org.sdk.interfaces
{
	import org.sdk.action.IActionHandler;

	public interface IKinetoplast
	{
		/*
		* 执行动作,不必在意动作的具体动作
		* */
		function runAction(action:IActionHandler,name:String=null):void;
		/*
		* 停止动画
		* */
		function stopAction(name:String, over:Boolean = false):void;
		/*
		 *真正执行的动作 
		 **/
		function hasAction(name:String):Boolean;
		/*
		* 停止所有动画
		* */
		function stopActions():void;
		//end
	}
}