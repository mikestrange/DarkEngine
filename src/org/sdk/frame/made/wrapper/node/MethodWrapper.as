package org.sdk.frame.made.wrapper.node {
	import org.sdk.frame.made.wrapper.interfaces.IEventHandler;
	import org.sdk.frame.made.wrapper.interfaces.IWrapper;
	
	/*
	 * 处理监听方法的媒介
	 * */
	public class MethodWrapper extends BaseWrapper 
	{
		public function MethodWrapper(target:Function, name:String) 
		{
			super(target, name);
		}
		
		protected function get method():Function
		{
			return _target as Function;
		}
		
		override public function eventHandler(event:IEventHandler):void 
		{
			if (isLive()) {
				method(event);
			}
		}
		//ends
	}

}