package org.sdk.display.com 
{
	import flash.events.Event;
	import org.sdk.display.core.BaseSprite;
	/**
	 * 组件基类
	 * @author Mike email:542540443@qq.com
	 */
	public class BaseComponent extends BaseSprite 
	{
		private var _isrun:Boolean = false;
		
		public function setRunning(value:Boolean = false):void
		{
			if (value == _isrun) return;
			_isrun = value;
			if (value) {
				this.addEventListener(Event.ENTER_FRAME, _runEnter);
			}else {
				this.removeEventListener(Event.ENTER_FRAME, _runEnter);
			}
		}
		
		private function _runEnter(event:Event):void
		{
			frameRender();
		}
		
		protected function frameRender(float:uint = 0):void
		{
			
		}
		
		override public function undepute():void 
		{
			setRunning();
			super.undepute();
		}
		//ends
	}

}