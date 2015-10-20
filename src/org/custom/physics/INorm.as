package org.custom.physics 
{
	
	/**
	 * 区域规范
	 * @author Mike email:542540443@qq.com
	 */
	public interface INorm 
	{
		function setPositionX(value:Number):void;
		function setPositionY(value:Number):void;
		function getPositionX():Number;
		function getPositionY():Number;
		//
		function get width():Number;
		function get height():Number;
		//区域类型
		function get type():int;
		//四个点
		function get left():Number;
		function get right():Number;
		function get top():Number;
		function get bottom():Number;
		//
		function isMiddleY(value:INorm):Boolean;
		function isMiddleX(value:INorm):Boolean;
		//瞄准,瞄准比如x方向瞄准
		function onTakeAim(target:INorm, name:String = null):void;
		//触碰或者是到达
		function onHitRegion(type:int, value:INorm):void;
		//end
	}
	
}