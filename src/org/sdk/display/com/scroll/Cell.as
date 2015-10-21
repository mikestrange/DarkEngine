package org.sdk.display.com.scroll 
{
	import org.sdk.display.core.KindSprite;
	/**
	 * 一个小块
	 */
	public class Cell extends KindSprite
	{
		private var _floor:int;
		private var _isopen:Boolean;
		
		public function Cell(index:int = 0)
		{
			setFloor(index);
		}
		
		public function setFloor(value:int):void
		{
			_floor = value;
		}
		
		public function get floor():int
		{
			return _floor;
		}
		
		public function setOpen(value:Boolean):void
		{
			_isopen = value;
		}
		
		public function isOpen():Boolean
		{
			return _isopen;
		}
		//ends
	}

}