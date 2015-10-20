package org.sdk.frame.made.wrapper.interfaces 
{
	/*
	 * 包装处理装置
	 * */
	public interface IWrapper
	{
		function eventHandler(event:IEventHandler):void;
		function match(value:Object):Boolean;
		function destroy():void;
		function get target():*;
		function get name():String;
		//end
	}
	
}