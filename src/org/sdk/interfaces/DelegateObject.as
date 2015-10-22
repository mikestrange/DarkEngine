package org.sdk.interfaces 
{
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class DelegateObject implements IObject 
	{
		private var _delegate:IDelegate;
		
		/* INTERFACE org.sdk.interfaces.IObject */
		
		public function get delegate():IDelegate 
		{
			return _delegate;
		}
		
		public function set delegate(value:IDelegate):void 
		{
			_delegate = value;
		}
		
		public function destroy():void 
		{
			
		}
		
		public function applyHandler(notice:String, target:Object = null):void 
		{
			
		}
		
		//ends
	}

}