package org.sdk.context 
{
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import org.sdk.debug.Log;
	/**
	 *域的管理
	 */
	public class ApplicationManager 
	{
		
		private static var _ins:ApplicationManager;
		
		public static function create():ApplicationManager
		{
			if (null == _ins) _ins = new ApplicationManager;
			return _ins;
		}
		
		//主域
		private var _typeKeys:Object = { };
		private var _app:ApplicationDomain;
		
		public function ApplicationManager(domain:ApplicationDomain = null)
		{
			if (domain == null) domain = ApplicationDomain.currentDomain;
			_app = domain;
		}
		
		//注册一个类型  不是Loader不会被注册
		public function addAppDomain(key:String, context:AppDomain):void
		{
			if (null == context) throw Error("不存在的域：" + key);
			if (undefined == _typeKeys[key]) {
				_typeKeys[key] = context;
				Log.info("保存一个域名：", key, context);
			}
		}
		
		public function hasAppDomain(key:String):Boolean
		{
			return undefined != _typeKeys[key];
		}
		
		public function getContext(key:String):AppDomain
		{
			return _typeKeys[key];
		}
		
		//取资源
		public function getAsset(name:String, key:String = null):Object
		{
			var Obj:Class = null;
			if (key == null) {
				if (_app.hasDefinition(name)) {
					Obj = _app.getDefinition(name) as Class;
				}
			}else {
				var apk:AppDomain = getContext(key);
				if (apk) Obj = apk.getClass(name);
			}
			if (Obj) return new Obj;
			Log.error("不存在的定义:", key, name);
			return null;
		}
		
		//ends
	}
}