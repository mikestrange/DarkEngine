package org.sdk.engine 
{
	
	public interface IRunning
	{
		function runEvent(event:Object = null):void;
		function isRunning():Boolean;
		function setRunning(value:Boolean):void;
		//end
	}
	
}