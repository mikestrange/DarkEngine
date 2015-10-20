package org.sdk.interfaces 
{
	
	public interface IObject 
	{
		/*
		* 委托
		* */
		function get delegate():IObject;
		/*
		 * 设置委托
		 * */
		function set delegate(value:IObject):void;
		/*
		 * 事件处理
		 * */
		function applyHandler(notice:String, target:Object = null):void;
		/*
		 * 摧毁-释放调用
		 * */
		function undepute():void;
		/*
		 * 唯一名称
		 * */
		function getCodeName():String;
		//end
	}
	
}