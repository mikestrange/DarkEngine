package org.sdk.display.tick 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.sdk.interfaces.ITicker;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class TickManager 
	{
		private var tickList:Vector.<Ticker>;
		private var _ticker:Sprite;
		private var _play:Boolean;
		private const ENTER_FRAME:String = "enterFrame";
		
		private static var _instance:TickManager;
		
		public static function getInstance():TickManager
		{
			if (null == _instance) {
				_instance = new TickManager;
			}
			return _instance;
		}
		
		public function TickManager() 
		{
			tickList = new Vector.<Ticker>;
			_ticker = new Sprite;
			this.play();
		}
		
		public function addTicker(tick:Ticker):void
		{
			tickList.push(tick);
		}
		
		private function runEnter(event:Object):void
		{
			if (tickList.length == 0) return;
			var tick:Ticker;
			for (var i:int = tickList.length - 1; i >= 0; i--) {
				tick = tickList[i];
				if (tick.isUnload) 
				{
					tickList.splice(i, 1);
					tick.cleanUp();
				}
			}
			for each(tick in tickList) tick.update();
		}
		
		//清理所有回调
		public function clean():void
		{
			for each(var tick:Ticker in tickList) 
			{
				tick.cleanUp();
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
		//ends
	}

}