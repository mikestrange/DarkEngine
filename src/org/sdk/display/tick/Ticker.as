package org.sdk.display.tick 
{
	import org.sdk.interfaces.ITicker;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class Ticker implements ITicker 
	{
		private var _obserList:Vector.<TickObserver>;
		private var _isUnload:Boolean = false;
		
		public function Ticker()
		{
			TickManager.getInstance().addTicker(this);
			_obserList = new Vector.<TickObserver>;
		}
		
		public function update():void
		{
			if (isUnload) return;
			if (_obserList.length == 0) return;
			var obser:TickObserver;
			for (var i:int = _obserList.length - 1; i >= 0; i--) {
				obser = _obserList[i];
				if (obser.isStop) {
					_obserList.splice(i, 1);
					obser.free();
				}
			}
			for each(obser in _obserList) obser.update();
		}
		
		public function cleanUp():void
		{
			if (_obserList.length) {
				const list:Vector.<TickObserver> = _obserList;
				_obserList = new Vector.<TickObserver>;
				for each(var obser:TickObserver in list)
				{
					obser.free();
				}
			}
		}
		
		public function get isUnload():Boolean
		{
			return _isUnload;
		}
		
		public function unload():void 
		{
			_isUnload = true;
		}
		
		/* interface */
		public function step(delay:Number, method:Function, time:int = 1, ...rest):void
		{
			_obserList.push(new TickObserver(method, delay, time, rest));
		}
		
		public function kill(method:Function):void
		{
			for each(var obser:TickObserver in _obserList) {
				if (!obser.isStop && obser.isMethod(method))
				{
					obser.stop();
				}
			}
		}
		//ends
	}

}