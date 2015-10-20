package org.sdk.display.com.interfaces 
{
	import org.sdk.interfaces.IBaseSprite;
	/**
	 * 元素
	 */
	public interface ICell extends IBaseSprite
	{
		function get floor():int;
		function setFloor(value:int):void;
		function setOpen(value:Boolean):void;
		function isOpen():Boolean;
		//ends
	}
	
}