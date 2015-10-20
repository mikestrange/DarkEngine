package org.sdk.classes.common 
{
	import flash.geom.Point;
	
	public class Maths 
	{
		private static const ROUND:int = 360;
		private static const ROUND_HALF:int = 180;
		private static const RIGHT_ANGLE:int = 90;
		
		public function Maths() 
		{
			throw Error("can not new this");
		}
		
		//随机范围
		public static function random(left:int, right:int):int
		{
			var len:int = (right + 1) - left;
			return left + (Math.random() * len | 0);
		}
		
		//随机一个数字列表
		public static function ranVector(left:int, right:int, times:uint = 1):Vector.<Number>
		{
			var vector:Vector.<Number> = new Vector.<Number>(times);
			for (var i:int = 0; i < times; i++) vector[i] = random(left, right);
			return vector;
		}
		
		//不能超过或者小于
		public static function scope(value:Number, min:Number, max:Number):Number
		{
			if (value < min) return min;
			if (value > max) return max;
			return value;
		}
		
		//波动数据
		public static function wave(value:int, leng:uint = 1):int
		{
			return random(value - leng, value + leng);
		}
		
		//****************************************
		//将一个角度转换成360的的范围
		public static function roundAngle(value:Number):Number
		{
			value = value % ROUND;
			if (value < 0)	return ROUND + value;
			return value;
		}
		
		//角度求弧度
		public static function obtainRadian(angle:Number):Number
		{
			return angle * (Math.PI / ROUND_HALF);
		}
		
		//弧度求角度
		public static function obtainAngle(radian:Number):Number
		{
			return radian * (ROUND_HALF / Math.PI);
		}
		
		//两点之间的弧度  value到other的弧度
		public static function atanRadian(selfx:Number, selfy:Number, aimx:Number = 0, aimy:Number = 0):Number
		{
			return Math.atan2(selfy - aimy, selfx - aimx);
		}
		
		//两点之间的角度  value到other的角度,不是360 是0-180,0-(-180)
		public static function atanAngle(selfx:Number, selfy:Number, aimx:Number = 0, aimy:Number = 0):Number
		{
			return atanRadian(selfx, selfy, aimx, aimy) * ROUND_HALF / Math.PI;
		}
		
		//两点距离
		public static function distance(mx:Number, my:Number, dx:Number, dy:Number):Number
		{
			var tx:Number = mx - dx;
			var ty:Number = my - dy;
			return Math.sqrt(tx * tx + ty * ty);
		}
		
		//合力
		public static function resultant(angle:int, speedx:Number = 1, speedy:Number = 1):Point
		{
			var dx:Number = Math.cos(angle * Math.PI / ROUND_HALF) * speedx;
			var dy:Number = Math.sin(angle * Math.PI / ROUND_HALF) * speedy;
			return new Point(dx, dy);
		}
		
		//ends
	}

}