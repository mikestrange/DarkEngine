package org.sdk.interfaces 
{
	
	public interface IObject extends IDelegate
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
		 * 摧毁-释放调用
		 * */
		function undepute():void;
		//end
	}
	
}