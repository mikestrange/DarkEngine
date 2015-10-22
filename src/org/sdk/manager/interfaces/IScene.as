package org.sdk.manager.interfaces 
{
	public interface IScene 
	{
		function getSceneName():String;
		function onEnter(data:*= undefined):void;
		function onExit():void;
		//ends
	}
	
}