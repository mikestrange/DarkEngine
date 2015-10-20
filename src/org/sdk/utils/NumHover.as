package org.sdk.utils 
{
	/**
	 * ...数字处理
	 * @author Mike email:542540443@qq.com
	 */
	public class NumHover 
	{
		private static const BUFFER:int = 1024;
		
		/*
		 * 大小处理 ,传入字节
		 * */
		public static function toKb(value:Number):String 
		{
			const num:Number = value / BUFFER;
			return num.toFixed(2) + "KB";
		}
		
		public static function toMb(value:Number):String
		{
			const num:Number = value / (BUFFER * BUFFER);
			return num.toFixed(2) + "MB";
		}
		
		public static function toGb(value:Number):String
		{
			const num:Number = value / (BUFFER * BUFFER * BUFFER);
			return num.toFixed(2) + "GB";
		}
		
		/*
		 * 时间处理 传入毫秒
		 * */
		public static function toTime(msec:int):String
		{
			return null;
		}
		
		//end
	}

}