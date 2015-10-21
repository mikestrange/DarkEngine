package org.sdk.manager 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.sdk.manager.member.TickObserver;
	import org.sdk.beyond_abysm;
	use namespace beyond_abysm;
	public class TickManager 
	{
		private static var _instance:TickManager;
		
		public static function getInstance():TickManager
		{
			if (null == _instance) {
				_instance = new TickManager;
			}
			return _instance;
		}
		
		//
		private const ENTER_FRAME:String = "enterFrame";
		private var tickList:Vector.<TickObserver>;
		private var _ticker:Sprite;
		private var _play:Boolean;
		
		public function TickManager() 
		{
			tickList = new Vector.<TickObserver>;
			_ticker = new Sprite;
			this.play();
		}
		
		public function addTicker(tick:TickObserver):void
		{
			//唯一先删除
			if (tick.isSole) {
				removeMethod(tick.getTarget(), tick.getMethod());
			}
			//不存在添加
			if (tickList.indexOf(tick) == -1) 
			{
				tickList.push(tick);
			}
		}
		
		public function removeTarget(target:Object):void
		{
			for each(var tick:TickObserver in tickList) 
			{
				if (tick.isTarget(target)) {
					tick.stop();
				}
			}
		}
		
		public function removeMethod(target:Object, method:Function):void
		{
			for each(var tick:TickObserver in tickList) 
			{
				if (tick.isTarget(target) && tick.isMethod(method))
				{
					tick.stop();
				}
			}
		}
		
		//清理所有回调
		public function cleanAll():void
		{
			for each(var tick:TickObserver in tickList) 
			{
				tick.stop();
			}
		}
		
		//启动
		public function play():void
		{
			if (!_play) 
			{
				_play = true;
				_ticker.addEventListener(ENTER_FRAME, runEnter);
			}
		}
		
		//暂停
		public function stop():void
		{
			if (_play) {
				_play = false;
				_ticker.removeEventListener(ENTER_FRAME, runEnter);
			}
		}
		
		private function runEnter(event:Object):void
		{
			if (tickList.length == 0) return;
			var tick:TickObserver;
			for (var i:int = tickList.length - 1; i >= 0; i--) {
				tick = tickList[i];
				if (tick.isStop) 
				{
					tickList.splice(i, 1);
					tick.free();
				}
			}
			for each(tick in tickList) tick.update();
		}
		//ends
	}

}