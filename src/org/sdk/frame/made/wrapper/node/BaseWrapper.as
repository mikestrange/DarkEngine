package org.sdk.frame.made.wrapper.node {
	import org.sdk.frame.made.wrapper.interfaces.IEventHandler;
	import org.sdk.frame.made.wrapper.interfaces.IWrapper;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class BaseWrapper implements IWrapper 
	{
		protected var _target:*= undefined;
		protected var _name:String;
		protected var _live:Boolean;
		
		public function BaseWrapper(target:*, name:String) 
		{
			this._target = target;
			this._name = name;
		}
		
		/* INTERFACE org.sdk.frame.made.interfaces.IWrapper */
		
		public function match(value:Object):Boolean 
		{
			return _target === value;
		}
		
		public function isLive():Boolean 
		{
			return _live;
		}
		
		public function destroy():void 
		{
			_live = false;
			_target = null;
		}
		
		
		public function get target():*
		{
			return _target;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function eventHandler(event:IEventHandler):void 
		{
			
		}
		
		//
		public function toString():String
		{
			return "{ target=" + _target + ", islife=" + _live+"}";
		}
		//ends
	}

}