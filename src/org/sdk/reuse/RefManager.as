package org.sdk.reuse 
{
	import flash.utils.Dictionary;
	import org.sdk.debug.Log;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.interfaces.IRender;
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
		
		private static const NONE:int = 0;
		
		//对象引用
		private var refMap:Dictionary;
		private var _leng:int;
		
		public function RefManager() 
		{
			refMap = new Dictionary;
			_leng = NONE;
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
			if (ref) ref.undepute();
		}
		
		public function clean():void
		{
			for each(var ref:IRefObject in refMap) 
			{
				ref.undepute();
			}
		}
		
		//内部员工
		internal function remove(name:String):void
		{
			if (hasRef(name)) {
				delete refMap[name];
				trace("移除Auto:", "[" + name+"]");
			}
		}
		
		//
		public function applyTo(target:IRender, name:String, data:Object = null):Boolean
		{
			var ref:IRefObject = getRef(name);
			if (ref) {
				target.washRender(ref);
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
			var chat:String = " CacheManager start->" + _leng;
			var name:String;
			for (name in refMap) 
			{
				const ref:IRefObject = getRef(name);
				chat += "\nname = " + name + ", target = " + ref.target + ", len = " + ref.refCount;
			}
			chat += "\n end -<";
			return chat;
		}
		//end
	}

}