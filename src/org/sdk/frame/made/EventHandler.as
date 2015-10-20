package org.sdk.frame.made
{
	import org.sdk.frame.made.wrapper.interfaces.IEventHandler;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class EventHandler implements IEventHandler 
	{
		private var _name:String;
		private var _data:*;
		private var _status:String;
		private var _type:int;
		
		public function EventHandler(name:String, data:*= undefined, status:String = null, type:int = 0) 
		{
			_name = name;
			_data = data;
			_status = status;
			_type = type;
		}
		
		/* INTERFACE org.sdk.frame.made.interfaces.IEventHandler */
		public function get name():String 
		{
			return _name;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function get status():String 
		{
			return _status;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		//ends
	}

}