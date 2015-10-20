package org.sdk.classes.common {
	import flash.geom.Point;
	import flash.display.Graphics;
	import org.sdk.classes.common.Maths;
	/*
	 * n次贝塞尔曲线
	 * */
	final public class Bezier 
	{
		
		public function Bezier() 
		{
			throw Error("do not new Bezier")
		}
		
		//n次
		private static function P_BEZ(t:Number, sz:Vector.<Point>):Point
		{
			var x_p:Number = 0;
			var y_p:Number = 0;
			var n:int = sz.length;
			for (var i:int = 0; i < sz.length; i++)
			{
				var b:Number = BEZ(n - 1, i, t);
				x_p +=  sz[i].x * b;
				y_p +=  sz[i].y * b;
			}
			return new Point(x_p, y_p);
		}
		
		//组合排序
		private static function C_BEZ(n:int, k:int):Number
		{
			var son:int = F_BEZ(n);
			var mother:int = F_BEZ(k) * F_BEZ(n - k);
			return son / mother;
		}
		
		//基函数
		private static function BEZ(n:int, k:int, t:Number):Number
		{
			return C_BEZ(n, k) * Math.pow(t, k) * Math.pow(1 - t, n - k);
		}
		
		//阶乘
		private static function F_BEZ(i:int):int
		{
			var n:int = 1;
			for (var j:int = 1; j <= i; j++) n *=  j;
			return n;
		}
		
		//times 0 - 1  sz 路线点,为1的时候表示结束
		public static function dot(times:Number, sz:Vector.<Point>):Point
		{
			var value:Number = Maths.scope(times, 0, 1);	//限制在0-1
			return P_BEZ(value, sz);
		}
		
		//画贝塞曲线
		public static function drawLine(graphics:Graphics, sz:Vector.<Point>, bezer:Boolean = true):void
		{
			for (var i:int = 0; i < sz.length; i++) {
				draw_point(graphics, sz[i]);
			}
			draw_lines(graphics, sz);
			graphics.lineStyle(2, 0xff0000);
			if (!bezer) return;
			var p:Point = P_BEZ(0, sz);
			graphics.moveTo(p.x, p.y);
			for (var j:Number = 0; j < 1; j += 0.01) {
				p = P_BEZ(j, sz);
				graphics.lineTo(p.x, p.y);
			}
			p = P_BEZ(1, sz);
			graphics.lineTo(p.x, p.y);
		}
		
		//画点
		private static function draw_point(graphics:Graphics, p:Point):void 
		{
			graphics.lineStyle(0);
			graphics.drawCircle(p.x, p.y, 3);
		}
		
		//画边
		private static function draw_lines(graphics:Graphics, sz:Vector.<Point>):void 
		{
			graphics.lineStyle(0, 0, 0.3);
			graphics.moveTo(sz[0].x, sz[0].y);
			for (var i:int = 0; i < sz.length; i++) {
				graphics.lineTo(sz[i].x, sz[i].y);
			}
		}
		
		//ends
	}

}