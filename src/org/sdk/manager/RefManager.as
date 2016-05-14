package org.sdk.manager {
	import flash.utils.Dictionary;
	import org.sdk.debug.Log;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.interfaces.IRender;
	import org.sdk.beyond_abysm;
	/**
	 * 缓存管理
	 * @author Mike email:542540443@qq.com
	 */
	public class RefManager 
	{
		private static var _ins:RefManager;
		
		public static function getInstance():RefManager
		{
			return _ins || (_ins = new RefManager);
		}
		
		//对象引用
		private var refMap:Dictionary;
		
		public function RefManager() 
		{
			refMap = new Dictionary;
		}
		
		public function addRef(ref:IRefObject):IRefObject
		{
			refMap[ref.name] = ref;
			trace("添加Auto:", "[" + ref.name+"]");
			return ref;
		}
		
		protected function getRef(name:String):IRefObject
		{
			return refMap[name];
		}
		
		public function hasRef(name:String):Boolean
		{
			return refMap[name] != undefined;
		}
		
		public function kill(name:String):void
		{
			const ref:IRefObject = getRef(name);
			if (ref) ref.finality();
		}
		
		public function clean():void
		{
			for each(var ref:IRefObject in refMap) 
			{
				ref.finality();
			}
		}
		
		//内部员工
		beyond_abysm function remove(name:String):void
		{
			if (hasRef(name)) {
				delete refMap[name];
				trace("移除Auto:", "[" + name+"]");
			}
		}
		
		/*应用到渲染器
		 * */
		public function applyTo(target:IRender, name:String, data:Object = null):Boolean
		{
			var ref:IRefObject = getRef(name);
			if (ref) {
				target.washRender(ref, data);
			}else {
				ref = target.getFailedHandler(name, data);
				if (ref) target.washRender(ref);
			}
			return ref != null;
		}
		
		/*
		 * 输出
		 * */
		public function toString():String
		{
			var chat:String = " RefManager start->";
			var name:String;
			var ref:IRefObject;
			var index:int = 0;
			for (name in refMap) 
			{
				ref = getRef(name);
				chat += "\n "+index+"->name = " + name + ", target = " + ref.target + ", len = " + ref.refCount;
				index++;
			}
			chat += "\n end -<";
			return chat;
		}
		//end
	}

}