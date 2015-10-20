package org.sdk.frame.made.wrapper.node {
	import org.sdk.frame.made.wrapper.interfaces.ICommand;
	import org.sdk.frame.made.wrapper.interfaces.IEventHandler;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class ObjectWrapper extends BaseWrapper 
	{
		
		public function ObjectWrapper(target:ICommand, name:String) 
		{
			super(target, name);
		}
		
		protected function get command():ICommand
		{
			return _target as ICommand;
		}
		
		override public function eventHandler(event:IEventHandler):void 
		{
			if (isLive()) {
				command.eventHandler(event);
			}
		}
		
		//
	}

}