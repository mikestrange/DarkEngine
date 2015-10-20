package org.sdk.lang 
{
	import com.adobe.utils.StringUtil;
	import flash.utils.getTimer;
	/*
	 * .ini文件
	 * */
	public class Conf 
	{
		private var _conf:Object;
		private var _global:Object;
		//通配标志
		private var _wildcard:* = undefined;
		private const LIM:int = 1;
		private	const BEGIN:int = 0;
		
		public function Conf(wildcard:*= null, defstr:String = "%s")
		{
			_wildcard = wildcard == null ? defstr : wildcard;
		}
		
		//也可以通过全局匹配
		public function Anima(key:String, ...args):String 
		{
			var chat:String = _global[key];
			if (chat) return replace(chat, args);
			return null;
		}
		
		public function getJson():String
		{
			return null;
		}
		
		//通过标签取部分
		public function part(tag:String, key:String, ...args):String
		{	
			tag = tag.toLowerCase();
			if (_conf[tag]) {
				var chat:String = _conf[tag][key];
				if (chat) return replace(chat, args);
				return null;
			}
			return null;
		}
		
		private function replace(chat:String, list:Array):String
		{
			if (list.length == BEGIN) return chat;
			//这种方式不能通配正则？可见能够通配正则
			var sects:Array = chat.split(_wildcard);
			var home:String = "";
			var leng:int = sects.length - 1;
			for (var i:int = BEGIN; i < leng; i++) {
				if (i >= list.length) {
					home += sects[i];
				}else {
					home += sects[i] + list[i];
				}
			}
			return home;
		}
		
		//解析
		public function decode(data:String, clear:Boolean = true):Object 
		{
			data = data.replace(/\r\n/g, "\n");
			data = data.replace(/\r/g, "\n");
			var list:Array = data.split(/\n/);
			var tag:String;		//当前标签
			var key:String;
			var value:String;
			var lineStr:String;
			var label:String;
			var map:Object;
			//是否清理之前的
			if (clear) {
				_conf = new Object;
				_global = new Object;
			}else {
				if (_conf == null) _conf = new Object;
				if (_global == null) _global = new Object;
			}
			trace("__________INI  START___________");
			for (var i:int = BEGIN; i < list.length; i++)
			{
				lineStr = list[i];
				if (lineStr.length > BEGIN) 
				{
					lineStr = StringUtil.trim(lineStr);
					var index:int = lineStr.search(/\[[A-Z0-9_]+\]/);
					if (index == BEGIN)
					{
						//[stageSize]标签行  标签转换成小写
						tag = StringUtil.trim(lineStr.toLowerCase());
						//截取[]里面的部分,如果里面还有也会被清理掉
						tag = tag.replace(/[\[\]]/ig, "");
						map = new Object;
						_conf[tag] = map;
					}else {
						if (lineStr.charAt() == "#") continue;
						var cutIndex:int = lineStr.indexOf("=");
						if (cutIndex != -1) {
							key = StringUtil.trim(lineStr.substr(BEGIN, cutIndex));
							value = StringUtil.trim(lineStr.substr(cutIndex + LIM));
							if (map) map[key] = value;
							_global[key] = value;	//全局匹配
							trace(i, tag + "->[ key = " + key + ", value = " + value+"]");
						}
					}
				}
			}
			trace("__________INI  END__________");
			//trace(Anima("LEVEL1",1,1))
			return null;
		}
		//end
	}
}