
package com.greensock.plugins
{
	import flash.geom.Matrix;
	import com.greensock.*;
	import com.greensock.motionPaths.*;
	
	public class CirclePath2DPlugin extends TweenPlugin 
	{
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		/** @private **/
		private static const _2PI:Number = Math.PI * 2;
		/** @private **/
		private static const _RAD2DEG:Number = 180 / Math.PI;
		
		/** @private **/
		protected var _target:Object;
		/** @private **/
		protected var _autoRemove:Boolean;
		/** @private **/
		protected var _start:Number;
		/** @private **/
		protected var _change:Number;
		/** @private **/
		protected var _circle:CirclePath2D;
		/** @private **/
		protected var _autoRotate:Boolean;
		/** @private **/
		protected var _rotationOffset:Number;
		
		/** @private **/
		public function CirclePath2DPlugin() {
			super();
			this.propName = "circlePath2D";
			this.overwriteProps = ["x","y"];
		}
		
		/** @private **/
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean {
			if (!("path" in value) || !(value.path is CirclePath2D)) {
				trace("CirclePath2DPlugin error: invalid 'path' property. Please define a CirclePath2D instance.");
				return false;
			}
			_target = target;
			_circle = value.path as CirclePath2D;
			_autoRotate = Boolean(value.autoRotate == true);
			_rotationOffset = value.rotationOffset || 0;
			
			var f:PathFollower = _circle.getFollower(target);
			if (f != null && !("startAngle" in value)) {
				_start = f.progress;
			} else {
				_start = _circle.angleToProgress(value.startAngle || 0, value.useRadians);
				_circle.renderObjectAt(_target, _start);
			}
			_change = Number(_circle.anglesToProgressChange(_circle.progressToAngle(_start), value.endAngle || 0, value.direction || "clockwise", value.extraRevolutions || 0, Boolean(value.useRadians)));
			return true;
		}
		
		/** @private **/
		override public function killProps(lookup:Object):void {
			super.killProps(lookup);
			if (("x" in lookup) || ("y" in lookup)) {
				this.overwriteProps = [];
			}
		}
		
		/** @private **/
		override public function set changeFactor(n:Number):void {
			var angle:Number = (_start + (_change * n)) * _2PI;
			var radius:Number = _circle.radius;
			var m:Matrix = _circle.transform.matrix;
			var px:Number = Math.cos(angle) * radius;
			var py:Number = Math.sin(angle) * radius;
			_target.x = px * m.a + py * m.c + m.tx;
			_target.y = px * m.b + py * m.d + m.ty;
			
			if (_autoRotate) {
				angle += Math.PI / 2;
				px = Math.cos(angle) * _circle.radius;
				py = Math.sin(angle) * _circle.radius;
				_target.rotation = Math.atan2(px * m.b + py * m.d, px * m.a + py * m.c) * _RAD2DEG + _rotationOffset;
			}
		}

	}
}