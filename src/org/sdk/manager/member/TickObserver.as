package org.sdk.manager.member 
{
	import flash.utils.getTimer;
	import org.sdk.beyond_abysm;
	import org.sdk.manager.TickManager;

	public class TickObserver 
	{
		private var _target:Object;
		private var _method:Function;
		private var _delay:int;
		private var _times:int;
		private var _args:Array;
		private var _sole:Boolean;
		private var _begin:int;
		private var _over:Boolean;
		
		public function TickObserver(target:Object)
		{
			_target = target;
		}
		
		public function applyMethod(method:Function, delay:int = 0, times:int = 1, sole:Boolean = false, ...args):void
		{
			this._method = method;
			this._delay = delay;
			this._times = times;
			this._sole = sole;
			this._args = args;
			this.start();
		}
		
		protected function start():void
		{
			this._over = false;
			this._begin = getTimer();
			TickManager.getInstance().addTicker(this);
		}
		
		public function stop():void
		{
			_over = true;
		}
		
		public function isTarget(target:Object):Boolean
		{
			return _target === target;
		}
		
		public function isMethod(method:Function):Boolean
		{
			return _method == method;
		}
		
		public function getMethod():Function
		{
			return _method;
		}
		
		public function getTarget():Object
		{
			return _target;
		}
		
		public function get isStop():Boolean
		{
			return _over;
		}
		
		public function get isSole():Boolean 
		{
			return _sole;	
		}
		
		//internal
		beyond_abysm function update():void
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
		
		beyond_abysm function free():void
		{
			_method = null;
			_args = null;
			_over = true;
		}
		//ends
	}

}