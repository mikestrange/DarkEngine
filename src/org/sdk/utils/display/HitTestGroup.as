package org.sdk.utils.display
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	        
	/**
	 * 成组物品碰撞
	 * 
	 */
	public class HitTestGroup
	{
		/**
		 * 遍历第2个物体的子对象并执行一次HitTestObject
		 * 
		 * @param target1
		 * @param target2
		 * @return 
		 * 
		 */
		public static function hitTestObjectChildren(target1:DisplayObject,target2:DisplayObject):Boolean
		{
			var size:int = (target2 is DisplayObjectContainer)?(target2 as DisplayObjectContainer).numChildren : 0;
			if (size == 0)
				return target1.hitTestObject(target2);
			else
			{
				for (var i:int = 0;i < size;i++)
				{
					if (target1.hitTestObject((target2 as DisplayObjectContainer).getChildAt(i)))
						return true;
				}
			}
			return false;
		}
		
		/**
		 * 遍历物体的子对象并执行一次HitTestPoint
		 * 
		 * @param target2
		 * @param x	舞台x
		 * @param y	舞台y
		 * @param shapeFlag	是否位图检测
		 * @return 
		 * 
		 */
		public static function hitTestPointChildren(target2:DisplayObject,x:Number,y:Number,shapeFlag:Boolean=false):Boolean
		{
			var size:int = (target2 is DisplayObjectContainer)?(target2 as DisplayObjectContainer).numChildren : 0;
			if (size == 0)
				return target2.hitTestPoint(x,y,shapeFlag);
			else
			{
				for (var i:int = 0;i < size;i++)
				{
					var item:DisplayObject = (target2 as DisplayObjectContainer).getChildAt(i);
					if (item.hitTestPoint(x,y))
					{
						if (shapeFlag)
						{
							if (item.hitTestPoint(x,y,shapeFlag))
								return true;
						}
						else
							return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * 遍历第2个物体的子对象并执行一次complexHitTestObject
		 *  
		 * @param target1
		 * @param target2
		 * @return 
		 * 
		 */
		public static function complexHitTestObjectChildren(target1:DisplayObject,target2:DisplayObject):Boolean
		{
			var size:int = (target2 is DisplayObjectContainer)?(target2 as DisplayObjectContainer).numChildren : 0;
			if (size == 0)
				return HitTest.complexHitTestObject(target1,target2);
			else
			{
				for (var i:int = 0;i < size;i++)
				{
					if (HitTest.complexHitTestObject(target1,(target2 as DisplayObjectContainer).getChildAt(i)))
						return true;
				}
			}
			return false;
		}
		
		
//		/**
//		 * 获得两个椭圆物品的交叠矩形
//		 *  
//		 * @param target1
//		 * @param target2
//		 * @return 
//		 * 
//		 */
//		public static function intersectionEllipse(target1:DisplayObject, target2:DisplayObject):Rectangle
//		{
//			if (!target1.stage || !target2.stage) 
//				return new Rectangle();
//			
//			var bounds1:Rectangle = target1.getBounds(target1.stage);
//			var bounds2:Rectangle = target2.getBounds(target2.stage);
//			
//			var intersect:Rectangle = bounds1.intersection(bounds2);
//			if (intersect.width==0)
//				return new Rectangle();
//			
//			var center1:Point = new Point(bounds1.x + bounds1.width / 2, bounds1.y + bounds1.height / 2);
//			var center2:Point = new Point(bounds2.x + bounds2.width / 2, bounds2.y + bounds2.height / 2);
//			var sub:Point = center2.subtract(center1);
//			var angle1:Number = Math.atan2(sub.y/bounds1.height,sub.x/bounds1.width);
//			var angle2:Number = Math.atan2(-sub.y/bounds2.height,-sub.x/bounds2.width);
//			var rad1:Point = new Point(bounds1.width / 2 * Math.cos(angle1),bounds1.height / 2 * Math.sin(angle1));
//			var rad2:Point = new Point(bounds2.width / 2 * Math.cos(angle2),bounds2.height / 2 * Math.sin(angle2));
//			if (sub.length > rad1.length + rad2.length)
//				return new Rectangle();
//			
//			var h1:Point = center1.add(rad1);
//			var h2:Point = center2.add(rad2);
//			return new Rectangle(h2.x,h2.y,h1.x - h2.x,h1.y - h2.y);
//		}
//		
//		/**
//		 * 获得椭圆和矩形物品的交叠矩形
//		 * 
//		 * @param target1	椭圆
//		 * @param target2	矩形
//		 * @return 
//		 * 
//		 */
//		public static function intersectionEllipseRectangle(target1:DisplayObject, target2:DisplayObject):Rectangle
//		{
//			if (!target1.stage || !target2.stage) 
//				return new Rectangle();
//			
//			var bounds1:Rectangle = target1.getBounds(target1.stage);
//			var bounds2:Rectangle = target2.getBounds(target2.stage);
//			
//			var intersect:Rectangle = bounds1.intersection(bounds2);
//			if (intersect.width==0)
//				return new Rectangle();
//			
//			var center1:Point = new Point(bounds1.x + bounds1.width / 2, bounds1.y + bounds1.height / 2);
//			var center2:Point = new Point(bounds2.x + bounds2.width / 2, bounds2.y + bounds2.height / 2);
//			
//			if ((center1.x < bounds2.x || center1.x > bounds2.right) && (center1.y < bounds2.y || center1.y > bounds2.bottom))
//			{
//				//未完成
//			}
//			return bounds1.intersection(bounds2);
//		}
		
	}
	
} 