package org.sdk.load.loads 
{
	import org.sdk.load.IResLoader;
	import org.sdk.load.type.LoadType;
	/*
	 * 下载资源的下载器管理
	 * */
	final public class LoadManager 
	{
		//定义类型
		private static const SWF_EXP:RegExp =/.swf/ig;
		private static const IMG_EXP:RegExp =/.jpg|.png|.jpeg|.bmp/ig;
		private static const TXT_EXP:RegExp =/.ini|.txt|.xml/ig;
		
		private static var sheetLoader:Array = [];
		private static const LIM:int = -1;
		
		//默认定义
		public static function setDefault():void
		{
			setLoader(LoadType.SWF, SwfLoader);
			setLoader(LoadType.IMG, ImageLoader);
			setLoader(LoadType.TXT, TextLoader);
			setLoader(LoadType.BYTE, ByteLoader);
		}
		
		public static function setSwfLoader(className:Class):void
		{
			setLoader(LoadType.SWF, className);
		}
		
		public static function setImgLoader(className:Class):void
		{
			setLoader(LoadType.IMG, className);
		}
		
		public static function setTextLoader(className:Class):void
		{
			setLoader(LoadType.TXT, className);
		}
		
		public static function setBaseLoader(className:Class):void
		{
			setLoader(LoadType.BYTE, className);
		}
		
		//自定义
		public static function setLoader(type:int, className:Class):void
		{
			sheetLoader[type] = className;
		}
		
		//取类型
		public static function getUrlType(url:String):int
		{
			if (url.search(SWF_EXP) != LIM) return LoadType.SWF;
			if (url.search(IMG_EXP) != LIM) return LoadType.IMG;
			if (url.search(TXT_EXP) != LIM) return LoadType.TXT;
			return LoadType.BYTE;
		}
		
		/*
		 * 取默认
		 * */
		public static function createDefLoader(url:String):IResLoader
		{
			const type:int = getUrlType(url);
			return new sheetLoader[type] as IResLoader;
		}
		
		/*
		 * 取自定义
		 * */
		public static function createLoader(type:int):IResLoader
		{
			return new sheetLoader[type] as IResLoader;
		}
		
		//end
	}

}