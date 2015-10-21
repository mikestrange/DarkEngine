package org.sdk.interfaces 
{
	
	public interface IObject 
	{
		/*
		* 委托
		* */
		function get delegate():IDelegate;
		/*
		 * 设置委托
		 * */
		function set delegate(value:IDelegate):void;
		/*
		* 处理应急事件
		* */
		function applyHandler(notice:String, target:Object = null):void;
		/*
		 * 摧毁-释放调用
		 * */
		function undepute():void;
		//end
	}
	
}