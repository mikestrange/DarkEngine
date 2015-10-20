package org.sdk.engine 
{
	import org.sdk.engine.MotivePower;
	import org.sdk.beyond_abysm;
	use namespace beyond_abysm;
	
	public class Running implements IRunning 
	{
		protected var _isrunning:Boolean;
		
		public function Running(value:Boolean = false)
		{
			setRunning(value);
		}
		
		/* INTERFACE org.sdk.interfaces.IRunning */
		public function runEvent(event:Object = null):void 
		{
			//trace("---")
		}
		
		public function isRunning():Boolean 
		{
			return _isrunning;
		}
		
		public function setRunning(value:Boolean):void 
		{
			if (value == _isrunning) return;
			value ? MotivePower.run(this) : MotivePower.stop(this);
			_isrunning = value;
		}
		
		//end
	}

}