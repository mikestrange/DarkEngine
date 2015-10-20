package org.sdk.engine 
{
	import flash.events.IEventDispatcher;
	import org.sdk.beyond_abysm;
	import org.sdk.debug.Log;
	import org.sdk.AppWork;
	use namespace beyond_abysm;
	
	/**
	 * 原动力
	 * @author Main
	 */
	final public class MotivePower 
	{
		private static const NONE:int = 0;
		private static const HAVE:int = 1;
		private static const Negative:int = -1;
		
		public static const ENTER_FRAME:String = "enterFrame";
		public static const STOP:Boolean = false;
		public static const PLAY:Boolean = true;
		
		beyond_abysm static var _speed:int = 1;
		beyond_abysm static var _pattern:String = "null";
		beyond_abysm static var _isrunning:Boolean = true;
		beyond_abysm static var _runsVector:Vector.<IRunning>;
		beyond_abysm static var _sunEventer:IEventDispatcher;
		
		public static function setRunDispatcher(dispatcher:IEventDispatcher = null):void
		{
			if (null == _sunEventer) {
				_sunEventer = dispatcher || AppWork.stage;
			}
		}
		
		/*
		* 对象内部调用
		 * */
		beyond_abysm static function run(target:IRunning):void
		{
			if (target.isRunning()) return;
			if (_runsVector == null) _runsVector = new Vector.<IRunning>;
			_runsVector.push(target);
			if (isExecuting()) {
				Log.debug("run ->", target);
				_sunEventer.addEventListener(ENTER_FRAME, target.runEvent);
			}
		}
		
		beyond_abysm static function stop(target:IRunning):void
		{
			if (_runsVector && target.isRunning())
			{
				const index:int = _runsVector.indexOf(target);
				if (index != Negative) _runsVector.splice(index, HAVE);
				if (_runsVector.length == NONE) _runsVector = null;
				if (isExecuting()) {
					Log.debug("stop ->", target);
					_sunEventer.removeEventListener(ENTER_FRAME, target.runEvent);
				}
			}
		}
		
		public static function stopAll():void
		{
			if (_runsVector == null || _isrunning == STOP) return;
			_isrunning = STOP;
			for each(var runer:IRunning in _runsVector)
			{
				_sunEventer.removeEventListener(ENTER_FRAME, runer.runEvent);
			}
		}
		
		public static function play():void
		{
			if (_runsVector == null || _isrunning == PLAY) return;
			_isrunning = PLAY;
			for each(var runer:IRunning in _runsVector)
			{
				_sunEventer.addEventListener(ENTER_FRAME, runer.runEvent);
			}
		}
		
		public static function get speed():int
		{
			return _speed;
		}
		
		//是否执行
		public static function isExecuting():Boolean
		{
			return _isrunning;
		}
		//ends
	}

}