package org.sdk.context 
{
	import flash.display.Loader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import org.sdk.debug.Log;
	
	/**
	 *单独的资源域
	 */
	public class AppDomain
	{
		private var applicationDomain:ApplicationDomain;
		private var portable_data:Object;
		
		public function AppDomain(checkFile:*, data:Object = null)
		{
			portable_data = data;
			if (checkFile is Loader) {
				applicationDomain = Loader(checkFile).contentLoaderInfo.applicationDomain;
			}else if (checkFile is ApplicationDomain) {
				applicationDomain = checkFile;
			}else {
				//throw Error("不存在的域解析，请提醒修改源代码！");
				Log.error("域名类型错误：", checkFile);
			}
		}
		
		public function getPortable():Object
		{
			return portable_data;
		}
		
		public function hasDefinition(name:String):Boolean
		{
			return applicationDomain.hasDefinition(name);
		}
		
		public function getClass(name:String):Class
		{
			if (applicationDomain.hasDefinition(name)) {
				return applicationDomain.getDefinition(name) as Class;
			}
			return null;
		}
		
		public function getObject(name:String):Object
		{
			var classDefine:Class = getClass(name);
			if (classDefine) return new classDefine;
			return null;
		}
		//ends
	}
}