package org.sdk.frame.made.wrapper.node {
	import org.sdk.frame.made.wrapper.interfaces.ICommand;
	import org.sdk.frame.made.wrapper.interfaces.IEventHandler;
	import org.sdk.frame.made.wrapper.interfaces.IWrapper;
	
	/*
	 * 处理Command的媒介
	 * */
	public class ClassWrapper extends BaseWrapper
	{
		public function ClassWrapper(target:Class, name:String) 
		{
			super(target, name);
		}
		
		protected function get command():ICommand
		{
			return (new _target) as ICommand;
		}
		
		override public function eventHandler(event:IEventHandler):void 
		{
			if (isLive()) {
				command.eventHandler(event);
			}
		}
		//ends
	}

}