package org.sdk.classes.common 
{
	import flash.utils.Dictionary;
	
	/*
	 * 哈希表函数
	 * */
	public class HashMap 
	{
		private var hashKey:Dictionary;
		private var length:uint = 0;
		
		public function HashMap() 
		{
			hashKey = new Dictionary;
		}
		
		public function get size():uint
		{
			return length;
		}
		
		public function isEmpty():Boolean
		{
			return length == 0;
		}
		
		public function getKeys():Array
		{
			var double:Array = new Array(length);
			var cur:int = 0;
			var key:String;
			for (key in hashKey)
			{
				double[cur] = key;
				cur++;
			}
			return double;
		}
		
		public function getValues():Array
		{
			var double:Array = new Array(length);
			var cur:int = 0;
			var value:*;
			for each(value in hashKey)
			{
				double[cur] = value;
				cur++;
			}
			return double;
		}
		
		public function isKey(key:String):Boolean
		{
			if (undefined == hashKey[key]) return false;
			return true;
		}
		
		public function isValue(value:*):Boolean
		{
			var double:*;
			for each(double in hashKey)
			{
				if (double === value) return true;
			}
			return false;
		}
		
		public function getValue(key:String):*
		{
			var value:*= hashKey[key];
			if (undefined === value) return null;
			return value;
		}
		
		public function eachKey(handler:Function):void
		{
			var key:String;
			for (key in hashKey) handler(key);
		}
		
		public function eachValue(handler:Function):void
		{
			var value:*= undefined;
			for each(value in hashKey) handler(value);
		}
		
		//允许替换,null将被删除键
		public function put(key:String, value:*):*
		{
			if (null == key) throw Error("this key is null!")
			if (null == value) return remove(key);
			if (!isKey(key)) {
				hashKey[key] = value;
				length++;
			}
			var former:* = getValue(key);
			hashKey[key] = value;
			return former;
		}
		
		public function remove(key:String):*
		{
			if (!isKey(key)) return null;
			var value:*= hashKey[key];
			delete hashKey[key];
			length--;
			return value;
		}
		
		public function clear():void
		{
			this.length = 0;
			this.hashKey = new Dictionary;
		}
		
		public function clone():HashMap
		{
			var hashmap:HashMap = new HashMap;
			var key:String;
			for (key in hashKey) {
				hashmap.put(key, hashKey[key]);
			}
			return hashmap;
		}
		
		public function toString():String
		{
			var keys:Array = getKeys();
			var values:Array = getValues();
			var char:String = "<----HashMap Start---->\n";
			var index:uint = 0;
			while (index < keys.length) {
				char = char + keys[index] + "->" + values[index] + "\n";
				index++;
			}
			char = char +"<---size="+length+" HashMap End--->";
			return char;
		}
		
		//ends
	}

}