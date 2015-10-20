package org.sdk.interfaces 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Main
	 */
	public interface INodeDisplay extends IObject
	{
		/*
		 * 设置位置
		 * */
		function setPosition(x:Number = 0, y:Number = 0):void;
		/*
		 * 等比缩放
		 * */
		function set scale(value:Number):void;
		/*
		 * 宽
		 * */
		function get sizeWidth():Number;
		/*
		 * 高
		 * */
		function get sizeHeight():Number;
		/*
		 * 定义尺寸
		 * */
		function setSize(wide:Number, heig:Number):void;
		/*
		 * 标记
		 * */
		function setTag(value:int):void;
		/*
		 * 默认：0
		 * */
		function getTag():int;
		/*
		 * 是否tag
		 * */
		function isTag(value:int):Boolean;
		/*
		 * 显示 visible = true
		 * */
		function show():void;
		/*
		 * 隐藏 visible = false
		 * */
		function hide():void;
		/*
		 * 自身转换
		 * */
		function get convertDisplayObject():DisplayObject;
		/*
		 * 移除
		 * */
		function removeFromParent(value:Boolean = true):void;
		/*
		 * 计时器
		 * */
		function get ticker():ITicker;
		/*
		 * 移除计时器
		 * */
		function removeTicker():void;
		//ends
	}
	
}