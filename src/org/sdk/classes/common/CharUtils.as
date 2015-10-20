package org.sdk.classes.common 
{
	import flash.utils.getQualifiedClassName;
	
	public final class CharUtils 
	{
		public static function getClassName(value:*):String 
		{
			return getQualifiedClassName(value).replace("::", ".");
		}
		
		//给一个数字字符前面补0,[radix默认十进制],不包括小数
		public static function formatNumber(number:Number, leng:int = 32, radix:int = 10):String
        {
			const value:String = number.toString(radix);
            if (value.length >= leng) return value;
			const ZEOR:String = "0";
            var char:String = "";
            var length:int = leng;
            while (length > 0)
            {
                char = char + ZEOR;
                --length;
            }
            char = char + value;
            return char.substr(char.length - leng);
        }
		
		//截取右边多长度
        public static function cutRight(char:String, length:int = 8) : String
        {
            if (char.length <= length) return char;
            return char.substr(char.length - length);
        }
		
		//截取左变多少长度
		public static function cutLeft(char:String, length:int = 8) : String
        {
            if (char.length <= length) return char;
            return char.substr(0, length);
        }
		
		//10000 转换成 100,000
		public static function replaceWithComma(value:Number, rep:String = ",") : String
        {
            var index:int = 0;
            var topArr:Array = null;
            var topStr:String = null;
            var arr:Array =  String(value).split(".");
            var crr:Array = String(arr[0]).split("");
            var dsp:int = String(arr[0]).split("").length % 3 == 0 ? (3) : (crr.length % 3);
            var str:String = String(arr[0]).substr(0, dsp);
            var length:int = crr.length;
            index = dsp;
            while (index < length)
            {
                str = str + (rep + crr[index] + crr[(index + 1)] + crr[index + 2]);
                index = index + 3;
            }
            if (arr.length >= 2)
            {
                topArr = String(arr[1]).split("");
                topStr = "";
                length = topArr.length;
                index = 0;
                while (index < length)
                {
                    
                    if (index != 0)
                    {
                        topStr = topStr + rep;
                    }
                    topStr = topStr + topArr[index];
                    if ((index + 1) < length)
                    {
                        topStr = topStr + topArr[(index + 1)];
                    }
                    if (index + 2 < length)
                    {
                        topStr = topStr + topArr[index + 2];
                    }
                    index = index + 3;
                }
                return str + "." + topStr;
            }
            return str;
        }
		
		
		//替换字符
		public static const MAT:String = "%t";
		
		public static function format(str:String, ...rests):String
		{
			if (rests.length) {
				for (var i:int = 0; i < rests.length; i++)
				{
					str = str.replace(MAT, rests[i]);
				}
			}
			return str;
		}
		
		//解析url  注意如果单一的本地路径就可能path是不存在的
		private static const parse_url:RegExp = /^(?:([A-Za-z]+):)?(\/{0,3})([0-9.\-A-Za-z]+)(?::(\d+))?(?:\/([^?#]*))?(?:\?([^#]*))?(?:#(.*))?$/;
		private static const names:Array = ['url', 'scheme', 'slash', 'host', 'port', 'path', 'query', 'hash'];
		
		public static function parseUrl(url:String):Object
		{
			var body:Object = parse_url.exec(url);
			var objs:Object = new Object;
			for(var k:String in body)
			{
				var index:Number = parseInt(k);
				if(isNaN(index)) continue;
				objs[names[index]] = body[k];
			}
			//for(var ks:String in objs) trace(ks," = ",objs[ks])
			return objs;
		}
		//end
	}

}