package org.sdk.key {
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class KeyEvent 
	{
		internal var $isDown:Boolean;
		internal var $downTime:int;
		internal var $code:int;
		
		public function KeyEvent(code:int, down:Boolean) 
		{
			this.$code = code;
			this.$isDown = down;
			this.$downTime = getTimer();
		}
		
		public function getCode():int
		{
			return $code;
		}
		
		public function get isSelfDown():Boolean
		{
			return $isDown;
		}
		
		public function get downTime():int
		{
			return $downTime;
		}
		
		/*
		 * 这里是可以作为别人关注
		 * */
		public function isKeyDown(code:int):Boolean
		{
			return KeyManager.isKeyDown(code);
		}
		
		/*
		 * 取一个按钮按下的时间
		 * */
		public function getDownTime(code:int):Number
		{
			return KeyManager.getDownTime(code);
		}
		//ends
	}

}