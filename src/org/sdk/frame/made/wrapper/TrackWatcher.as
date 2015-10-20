package org.sdk.frame.made.wrapper 
{
	import flash.utils.Dictionary;
	import org.sdk.frame.made.wrapper.interfaces.IEventHandler;
	import org.sdk.frame.made.wrapper.interfaces.IWrapper;
	/*
	 * 追踪器
	 * */
	public class TrackWatcher
	{
		private var compare:Dictionary = new Dictionary;
		/*
		 * 添加一个监听
		 * */
		public function addListener(name:String, endless:IWrapper):void
		{
			var v:Vector.<IWrapper> = this.compare[name] as Vector.<IWrapper>;
			if (!v) {
				v = new Vector.<IWrapper>;
				this.compare[name] = v;
			}
			v.push(endless);
		}
		
		/*
		 * 移除一个监听
		 * */
		public function removeListener(name:String, target:Object):IWrapper 
		{
			var v:Vector.<IWrapper> = this.compare[name] as Vector.<IWrapper>;
			if (!v) return null;
			var wrap:IWrapper;
			for (var i:int = v.length - 1; i >= 0; i--)
			{
				wrap = v[i];
				if (wrap.match(target)) {
					wrap.destroy();
					v.splice(i, 1);
					break;
				}
			}
			if (v.length == 0) delete this.compare[name];
			return wrap;
		}
		
		/*
		 * 删除一条命令集合
		 * */
		public function removeLink(name:String = null):void 
		{
			if (name == null) {
				var k:String;
				for (k in this.compare) removeLink(k);
			}else {
				var v:Vector.<IWrapper> = this.compare[name] as Vector.<IWrapper>;
				if (!v) return;
				delete this.compare[name];
				const begin:int = 0;
				while (v.length) {
					v[begin].destroy();
					v.shift();
				}
			}
		}
		
		/*
		 * 是否存在监听
		 * */
		public function hasListener(name:String):Boolean 
		{
			return this.compare[name] != undefined;
		}
		
		/*
		 * 是否存在一个具体的监听
		 * */
		public function hasTargetListener(name:String, target:Object):Boolean 
		{
			var v:Vector.<IWrapper> = this.compare[name] as Vector.<IWrapper>;
			if (v) {
				for each(var wrap:IWrapper in v) {
					if(wrap.match(target)) return true
				}
			}
			return false
		}
		
		/*
		 * 唯一发送的方式
		 * */
		public function sendListener(event:IEventHandler):void 
		{
			var v:Vector.<IWrapper> = this.compare[event.name] as Vector.<IWrapper>;
			if (!v) return;
			const list:Vector.<IWrapper> = v.slice(0, v.length);
			const leng:int = list.length;
			for (var index:int = 0; index < leng; index++) 
			{
				list[index].eventHandler(event);
			}
		}
		
		public function toString():String
		{
			var chat:String = "start->";
			for (var k:String in compare) {
				chat += "\nkey=" + k + ", list=" + compare[k];
			}
			chat+="\n<-end"
			return chat;
		}
		//ends
	}
}