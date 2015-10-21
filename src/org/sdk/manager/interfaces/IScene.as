package org.sdk.manager.interfaces {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Main
	 */
	public interface IScene 
	{
		function getSceneName():String;
		function onEnter(data:*= undefined):void;
		function onExit():void;
		//ends
	}
	
}