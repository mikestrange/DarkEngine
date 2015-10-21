package org.sdk.key {
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class KeyEvent 
	{
		private var _downTime:uint;
		private var _code:uint;
		
		public function KeyEvent(code:uint) 
		{
			this._code = code;
			this._downTime = getTimer();
		}
		
		public function get code():uint
		{
			return _code;
		}
		
		public function getDownTimer():uint
		{
			return _downTime;
		}
		
		//ends
	}

}