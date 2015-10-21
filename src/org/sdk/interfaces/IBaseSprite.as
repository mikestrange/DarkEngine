package org.sdk.interfaces 
{	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public interface IBaseSprite extends INodeDisplay
	{
		/*
		 * 添加孩子
		 * */
		function addNodeDisplay(node:INodeDisplay, floor:int = -1):INodeDisplay;
		/*
		 * 移除释放所有子对象，自身不释放
		 * */
		function removeEveryChildren():void;
		/*
		 * 移除释放带名字的子对象
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
		 * 遍历所有子对象，识别tag,就算中途有被移除的也会执行函数
		 * */
		function eachChildrenHandler(handler:Function, tag:int = 0):void;
		//end
	}
	
}