package org.sdk.frame.made 
{
	import org.sdk.frame.made.EventHandler;
	import org.sdk.frame.made.wrapper.interfaces.ICommand;
	import org.sdk.frame.made.wrapper.interfaces.IWrapper;
	import org.sdk.frame.made.wrapper.node.ClassWrapper;
	import org.sdk.frame.made.wrapper.node.MethodWrapper;
	import org.sdk.frame.made.wrapper.node.ObjectWrapper;
	import org.sdk.frame.made.wrapper.TrackWatcher;
	
	/**
	 * 监听器扩张
	 * @author Mike email:542540443@qq.com
	 */
	public class PureListener
	{
		private var _tracker:TrackWatcher;
		
		public function PureListener(tracker:TrackWatcher = null) 
		{
			if (tracker) {
				setWatcher(tracker);
			}else {
				setWatcher(new TrackWatcher);
			}
		}
		
		public function setWatcher(tracker:TrackWatcher):void
		{
			if (_tracker) _tracker.removeLink();
			_tracker = tracker;
		}
		
		public function getWatcher():TrackWatcher
		{
			return _tracker;
		}
		
		public function sendEvents(data:* = undefined, ...rest):void 
		{
			for (var i:int = 0; i < rest.length; i++) 
			{
				const str:String = rest[i];
				if (str) {
					_tracker.sendListener(new EventHandler(str, data));
				}
			}
		}
		
		public function addHandlers(list:Array, target:*):void
		{
			for (var i:int = 0; i < list.length; i++) {
				const str:String = list[i];
				if (str) addHandler(str, target);
			}
		}
		
		public function removeHandlers(list:Array, target:*):void
		{
			for (var i:int = 0; i < list.length; i++) {
				const str:String = list[i];
				if (str) removeHandler(str, target);
			}
		}
		
		public function addHandler(name:String, target:*):void
		{
			var wrap:IWrapper;
			if (target is ICommand) {
				wrap =  new ObjectWrapper(target as ICommand, name);
			}else if (target is Function) {
				wrap =  new MethodWrapper(target as Function, name);
			}else if (target is Class) {
				wrap =  new ClassWrapper(target as Class, name);
			}
			_tracker.addListener(name, wrap);
		}
		
		public function removeHandler(name:String, target:*):void
		{
			_tracker.removeListener(name, target);
		}
		//ends
	}

}