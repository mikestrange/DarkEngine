package org.sdk.action.core 
{
	import flash.utils.getTimer;
	import org.sdk.action.IActionHandler;
	import org.sdk.engine.Running;
	import org.sdk.utils.easing.EaseLookup;
	
	public class BaseAction extends Running implements IActionHandler
	{
		//默认延迟
		public static const DEF_DELAY:int = 0;
		//秒
		public static const SEC:int = 1000;
		//默认动画时间
		public static const MOVIE_TIME:Number = 1;
		//缓动函数 key
		public static const EASEING:String = "ease";
		//延迟  key
		public static const DELAY:String = "delay";
		//传递值  key
		public static const RETURN_VALUE:String = "args";
		//结束调用  key
		public static const COMPLETE:String = "complete";
		//开始调用  key
		public static const START_CALL:String = "start";
		/*
		 * easing 函数
		 * rote =（进行时间,0,1,总时间）
		 * rote一个比例值
		 * currentValue = startValue + rote*endValue
		 * */
		//保存值
		protected var _endHash:Object;
		protected var _startHash:Object;
		//传入的值(不要随意修改)
		protected var _target:Object;
		protected var _refValue:Object;
		protected var _runtime:Number;  			//动画时间（传入是秒，转换成毫秒）
		//计算时候用的值(不要随意修改)
		protected var _isfree:Boolean;
		protected var _isplay:Boolean;
		protected var _starttime:Number;
		//允许参数
		protected var _delay:Number;				//延迟时间（传入是秒，转换成毫秒）
		protected var _returnValue:Array = null; 	//结束函数参数
		protected var _easeFun:Function = null;		//动画函数
		protected var _onComplete:Function = null;	//结束函数
		protected var _onStart:Function = null;		//开始函数
		
		//同类型属性应该被替代
		public function execute(target:Object, refer:Object, runtime:Number = 1):void
		{
			_isfree = false;
			_isplay = false;
			_target = target;
			_runtime = runtime * SEC;
			_refValue = refer;
			_endHash = { };
			_startHash = { };
			this.parseRefer(refer);
			//判断开始情况
			_starttime = getTimer();
			if (_delay <= DEF_DELAY) start_call();
			//---循环监听
			this.setRunning(true);
		}
		
		//设置初始化参数
		protected function parseRefer(refer:Object):void
		{
			if (refer[EASEING]) {
				_easeFun = EaseLookup.find(refer[EASEING]);
			}else {
				_easeFun = BaseAction.easeOut;
			}
			if (refer[DELAY]) {// is Number
				_delay = refer[DELAY] * SEC;
				if (_delay < DEF_DELAY) _delay = DEF_DELAY;
			}else {
				_delay = DEF_DELAY;
			}
			if (refer[RETURN_VALUE]) {
				if (refer[RETURN_VALUE] is Array) _returnValue = refer[RETURN_VALUE] as Array;
				else _returnValue = [refer[RETURN_VALUE]];
			}else {
				_returnValue = [];
			}
			if (refer[COMPLETE] is Function) {
				_onComplete = refer[COMPLETE];
			}else {
				_onComplete = null;
			}
			if (refer[START_CALL] is Function) {
				_onStart = refer[START_CALL];
			}else {
				_onStart = null;
			}
		}
		
		override public function runEvent(event:Object = null):void 
		{
			const intervaltime:int = getTimer() - _starttime;
			if (_isplay)
			{
				//运行阶段时间
				if (intervaltime >= _runtime) 
				{
					complete_call()
				}else{
					const rote:Number = _easeFun(intervaltime, 0, 1, _runtime);
					for (var property:String in _startHash) 
					{
						$updateValue(property, rote);
					}
				}
			}else {
				if (intervaltime > _delay) start_call();
			}
		}
		
		//刷新
		private function $updateValue(property:String, rote:Number):void
		{
			var startValue:Number = _startHash[property];
			var endValue:Number = _endHash[property];
			var currentValue:Number = startValue + rote * endValue;
			_target[property] = currentValue;
		}
		
		//结束调用
		protected function complete_call():void
		{
			this.setRunning(false);
			if (_onComplete is Function) {
				_onComplete.apply(_target, _returnValue);
			}
		}
		
		//开始调用,注意：只会把当前对象传递过来
		protected function start_call():void
		{
			//注册属性
			const NumType:String = "number"
			for (var property:String in _refValue)
			{
				if (property == EASEING || property == DELAY || property == RETURN_VALUE || 
				property == COMPLETE || property == START_CALL) continue;
				//设置初始化
				if (typeof(_target[property]) == NumType) 
				{
					_endHash[property] = _refValue[property];
					_startHash[property] = _target[property];
				}
			}
			_isplay = true;
			_starttime = getTimer();
			if (_onStart is Function) _onStart(_target);
		}
		
		//释放值
		public function cleanAndStop():void
		{
			this.setRunning(false);
			_endHash = null;
			_startHash = null;
			_target = null;
			_refValue = null;
			_easeFun = null;
			_onComplete = null;
			_returnValue = null;
			_onStart = null;
			_isfree = true;
		}
		
		//停止动作					是否到终止位置			是否执行回调
		public function stopAction(toend:Boolean = false, iscomplete:Boolean = false):void 
		{
			if (_isfree) return;
			if (toend) {
				for (var property:String in _endHash) {
					_target[property] = _endHash[property];
				}
			}
			if (iscomplete) {
				this.complete_call();
			}else {
				this.setRunning(false);
			}
		}
		
		//默认缓动函数
		protected static function easeOut(t:Number, b:Number, c:Number, d:Number):Number 
		{
			return 1 - (t = 1 - (t / d)) * t;
		}
		//ends
	}

}