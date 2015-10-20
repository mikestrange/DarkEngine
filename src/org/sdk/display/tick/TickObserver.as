package org.sdk.display.tick 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class TickObserver 
	{
		private var _method:Function;
		private var _delay:int;
		private var _times:int;
		private var _args:Array;
		private var _begin:int;
		private var _free:Boolean;
		
		public function TickObserver(method:Function, delay:int, times:int, args:Array)
		{
			this._method = method;
			this._delay = delay;
			this._times = times;
			this._args = args;
			_begin = getTimer();
			_free = false;
		}
		
		public function update():void
		{
			if (isStop) return;
			const interval:int =  getTimer() - _begin;
			if (interval >= _delay)
			{
				if (_times <= 0) {
					_method.apply(null, _args);
				}else {
					if (--_times == 0) {
						stop();
					}
					_method.apply(null, _args);
				}
				_begin = getTimer();
			}
		}
		
		public function isMethod(method:Function):Boolean
		{
			return _method == method;
		}
		
		public function stop():void
		{
			_free = true;
		}
		
		public function get isStop():Boolean
		{
			return _free;
		}
		
		public function free():void
		{
			_method = null;
			_args = null;
			_free = true;
		}
		//ends
	}

}