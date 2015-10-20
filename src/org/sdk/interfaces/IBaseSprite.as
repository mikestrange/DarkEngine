package org.sdk.interfaces 
{	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public interface IBaseSprite extends INodeDisplay
	{
		/*
		 * 
		 * */
		function addNodeDisplay(node:INodeDisplay, floor:int = -1, tag:int = 0):INodeDisplay;
		/*
		 * 移除释放所有子对象
		 * */
		function removeEveryChildren():void;
		/*
		 * 移除名称
		 * */
		function removeByName(childName:String):DisplayObject;
		/*
		 * 取所有包含tag的子对象
		 * */
		function getChildByTag(tag:int):INodeDisplay;
		/*
		 * 自身转换
		 * */
		function get convertSprite():Sprite;
		/*
		 * 遍历所有子对象，识别tag
		 * */
		function eachChildrenHandler(handler:Function, tag:int = 0):void;
		//end
	}
	
}