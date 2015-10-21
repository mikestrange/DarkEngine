package org.sdk.key {
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class KeyEvent 
	{
		private var _event:KeyboardEvent;
		private var _downTime:uint;
		private var _code:uint;
		
		public function KeyEvent(code:uint, event:KeyboardEvent) 
		{
			this._code = code;
			this._event = event;
			this._downTime = getTimer();
		}
		
		public function get code():uint
		{
			return _code;
		}
		
		public function set event(value:KeyboardEvent):void
		{
			_event = value;
		}
		
		public function get event():KeyboardEvent
		{
			return _event;
		}
		
		public function getDownTimer():uint
		{
			return _downTime;
		}
		
		//ends
	}

}