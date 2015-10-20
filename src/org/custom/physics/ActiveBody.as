package org.custom.physics 
{
	/**
	 * 活动体
	 * ...只做物理测试，不做旋转以及变形处理
	 * ...这里只做横版
	 * @author Mike email:542540443@qq.com
	 */
	public class ActiveBody
	{
		private static const NONE:int = 0;
		//被应用的一个区域
		private var _user:INorm;
		//
		public var wallopx:Number; 						//x冲击力
		public var wallopy:Number; 						//x冲击力
		public var friction:Number;						//摩擦力
		public var inertia:Number;						//惯性值  (和质量有关系)
		public var strength:Number;						//抗击力  ()
		//
		public const speed:Number = 5;					//上升速度
		public const gravity:Number = 0.98;				//重力加速度
		public var omitGravity:Boolean = false;			//是否忽略重力
		private var _addspeed:Number = 0;				//当前加速度
		private var _thrust:Number;						//上冲力
		
		public function ActiveBody(user:INorm = null) 
		{
			setUser(user);
		}
		
		//设置对象清空
		public function setUser(user:INorm):void
		{
			restore();
			_user = user;
		}
		
		public function get data():INorm
		{
			return _user;
		}
		
		//恢复初始，也就是禁止
		public function restore():void
		{
			wallopx = 0;
			wallopy = 0;
			inertia = 0;
			friction = 0;
			strength = 0;
			_addspeed = NONE;
			_thrust = NONE;
		}
		
		//最终渲染和行为有关系
		public function endRender(lumps:Array, checkType:int = 0):void
		{
			checkGravity();
			checkLeft(lumps);
			checkRight(lumps);
			checkHeader(lumps);
			checkBottom(lumps);
		}
		
		//校正重力
		private function checkGravity():void
		{
			if (omitGravity) return;
			_addspeed = _addspeed + speed;
			_addspeed *= gravity;
			wallopy = _addspeed - _thrust;
		}
		
		//设置一个冲量
		public function setThrust(value:Number):void
		{
			if (omitGravity) return;
			_thrust = value;
			_addspeed = NONE;
		}
		
		public function isLanded():Boolean
		{
			return _thrust == NONE;
		}
		
		protected function checkLeft(limts:Array):void
		{
			if (wallopx > NONE) 
			{
				var endValue:Number = data.getPositionX() + wallopx;
				limts.sortOn(NormDefine.STR_LEFT, Array.NUMERIC);
				//trace("move right")
				for (var i:int = 0; i < limts.length; i++) {
					var nearby:INorm = limts[i];
					if (nearby.left >= data.right && nearby.isMiddleY(data)) {
						if (nearby && data.right + wallopx > nearby.left) {
							endValue = nearby.left - data.width;
							data.onHitRegion(NormDefine.RIGHT, nearby);
						}
						//互相瞄准
						data.onTakeAim(nearby, NormDefine.AIM_X);
						break;
					}
				}
				//
				data.setPositionX(endValue);
			}
		}
		
		protected function checkRight(limts:Array):void
		{
			if (wallopx < NONE) {
				var endValue:Number = data.getPositionX() + wallopx;
				limts.sortOn(NormDefine.STR_RIGHT, Array.NUMERIC);
					//trace("move left")
				for (var k:int = limts.length - 1; k >= 0 ; k--) {
					var nearby:INorm = limts[k];
					if (data.left >= nearby.right && nearby.isMiddleY(data)) {
						if (nearby && data.left + wallopx < nearby.right) {
							endValue = nearby.right;
							data.onHitRegion(NormDefine.LEFT, nearby);
						}
						//瞄准
						data.onTakeAim(nearby, NormDefine.AIM_X);
						break;
					}
				}
				//
				data.setPositionX(endValue);
			}
		}
		
		protected function checkHeader(limts:Array):void
		{
			if (wallopy > NONE) {
				var endValue:Number = data.getPositionY() + wallopy;
				limts.sortOn(NormDefine.STR_TOP, Array.NUMERIC);
				//trace("move down")
				for (var i:int = 0; i < limts.length; i++) {
					var nearby:INorm = limts[i];
					if (nearby.top >= data.bottom && nearby.isMiddleX(data)) 
					{
						if (nearby && data.bottom + wallopy > nearby.top) {
							endValue = nearby.top - data.height;
							//落地表示，如果考虑到重力，那么一直会响应
							setThrust(NONE);
							data.onHitRegion(NormDefine.BOTTOM, nearby);
						}
						//瞄准
						data.onTakeAim(nearby, NormDefine.AIM_Y);
						break;
					}
				}
				data.setPositionY(endValue);
			}
		}
		
		protected function checkBottom(limts:Array):void
		{
			if (wallopy < NONE) {
				var endValue:Number = data.getPositionY() + wallopy;
				limts.sortOn(NormDefine.STR_BOTTOM, Array.NUMERIC);
				//trace("move up")
				for (var k:int = limts.length - 1; k >= 0; k--) {
					var nearby:INorm = limts[k];
					if (data.top >= nearby.bottom && nearby.isMiddleX(data)) 
					{
						if (nearby && data.top + wallopy < nearby.bottom) {
							endValue = nearby.bottom;
							data.onHitRegion(NormDefine.TOP, nearby);
						}
						//瞄准
						data.onTakeAim(nearby, NormDefine.AIM_Y);
						break;
					}
				}
				//最终结果
				data.setPositionY(endValue);
			}
		}
		//end
	}

}