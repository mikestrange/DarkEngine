package org.sdk.frame.made.wrapper.interfaces 
{
	/**
	 * 事件处理机制
	 */
	public interface IEventHandler 
	{
		function get name():String;
		function get data():*;
		function get status():String;
		function get type():int;
		//end
	}
	
}