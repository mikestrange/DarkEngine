package org.sdk.classes.common 
{

	import flash.utils.Dictionary;
	/*哈希表函数*/
	public class MapInteger 
	{
		private var hashKey:Dictionary;
		private var length:uint = 0;
		
		public function MapInteger() 
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
			var num:*;
			for (num in hashKey)
			{
				double[cur] = num as Number;
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
		
		public function isKey(num:Number):Boolean
		{
			if (undefined == hashKey[num]) return false;
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
		
		public function getValue(num:Number):*
		{
			var value:*= hashKey[num];
			if (undefined === value) return null;
			return value;
		}
		
		public function eachKey(handler:Function):void
		{
			for (var num:* in hashKey) handler(num);
		}
		
		public function eachValue(handler:Function):void
		{
			var value:*= undefined;
			for each(value in hashKey) handler(value);
		}
		
		//允许替换,null将被删除键
		public function put(num:Number, value:*):*
		{
			if (isNaN(num)) throw Error("this key is null!")
			if (null == value) return remove(num);
			if (!isKey(num)) {
				hashKey[num] = value;
				length++;
			}
			var former:* = getValue(num);
			hashKey[num] = value;
			return former;
		}
		
		public function remove(num:Number):*
		{
			if (!isKey(num)) return null;
			var value:*= hashKey[num];
			delete hashKey[num];
			length--;
			return value;
		}
		
		public function clear():void
		{
			this.length = 0;
			this.hashKey = new Dictionary;
		}
		
		public function clone():MapInteger
		{
			var hashmap:MapInteger = new MapInteger;
			for (var num:* in hashKey) {
				hashmap.put(num as Number, hashKey[num]);
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