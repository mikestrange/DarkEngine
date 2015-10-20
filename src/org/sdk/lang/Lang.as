package org.sdk.lang 
{
	//自定义
	//private static var _replaceEnter:RegExp =/[\r][\n]/gi;
	//private static var _replacex:RegExp =/<0>/gi;
	public final class Lang
	{
		/*一个简单的语言包诞生*/
		private static var _langKey:Object = new Object;
		//这个是第一个字段值和键的区分
		public static var SPLIT_CHAR:RegExp = /#/;
		
		//设置全局语言，换行符会被替换            一个文本			分割字符	 清理之前的所有
		public static function setLanguage(language:Object, split:String = "?>", cut:Boolean = false):void
		{
			if (cut) setLang(new Object);
			var lg:String = (language as String).replace(/[\r][\n]/gi, "");
			var arr:Array = lg.split(split);
			var str:String;
			var index:int;
			var key:*;
			var value:String;
			for (var i:int = 0; i < arr.length; i++)
			{
				str = arr[i];
				index = str.search(SPLIT_CHAR);  //搜索的是第一个字符，并不是全局
				if ( -1 == index) continue;
				key = str.substr(0, index);		//取第一个作为键
				value = str.substr(++index);	//取第二个作为值
				_langKey[key] = value;			//同键会被替换
			}
			//ends
			/*
			trace("[--LANG START--]");
			for (var c:* in _langKey) trace("[key=" + c + ",value=" + _langKey[c] + "]");
			trace("[--LANG END--]");
			*/
		}
		
		//直接设置
		public static function setLang(value:Object):void
		{
			_langKey = value;
		}
		
		//语言对应值  可以转换为json
		public static function getLang():Object 
		{
			return _langKey;
		}
		
		//取一个语言，逐个替换,可能会出现问题
		public static function cookie(index:String, ...replace):String 
		{
			var chat:String = _langKey[index];
			if (null == chat) return index + "";
			if (replace.length) {
				for (var i:int = replace.length - 1; i >= 0; i--) 
				{
					chat = chat.replace("{" + i + "}", replace[i]);
				}
			}
			return chat;
		}
		//ends
	}

}