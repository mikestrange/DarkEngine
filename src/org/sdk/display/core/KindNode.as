package org.sdk.display.core 
{
	import org.sdk.AppWork;
	import flash.display.BitmapData;
	import org.sdk.interfaces.IKindSprite;
	import org.sdk.manager.member.TickObserver;
	import org.sdk.manager.TickManager;
	import org.sdk.interfaces.IRefObject;
	import flash.display.DisplayObject;
	import org.sdk.interfaces.INodeDisplay;
	import org.sdk.manager.member.RefObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class KindNode extends MapSheet implements INodeDisplay 
	{
		private var _tag:int;
		private var _sizeWidth:Number;
		private var _sizeHeight:Number;
		
		public function KindNode(res:String=null) 
		{
			super(res);	
		}
		
		override public function getFailedHandler(name:String, data:Object = null):IRefObject 
		{
			const bit:BitmapData = AppWork.getObject(name) as BitmapData;
			if (bit) return new RefObject(name, bit);
			return super.getFailedHandler(name, data);
		}
		
		//直接渲染
		override protected function updateRender(target:*, data:Object):void
		{
			this.setTexture(target);
		}
		
		/* INTERFACE org.sdk.interfaces.INodeDisplay */
		public function setPosition(x:Number = 0, y:Number = 0):void 
		{
			this.x = x;
			this.y = y;
		}
		
		public function set scale(value:Number):void 
		{
			this.scaleX = this.scaleY = value;
		}
		
		public function get sizeWidth():Number 
		{
			return _sizeWidth;
		}
		
		public function get sizeHeight():Number 
		{
			return _sizeHeight;
		}
		
		public function setSize(wide:Number, high:Number):void 
		{
			this._sizeWidth = wide;
			this._sizeHeight = high;
		}
		
		public function setTag(value:int):void 
		{
			_tag = value;
		}
		
		public function getTag():int 
		{
			return _tag;
		}
		
		public function isTag(value:int):Boolean 
		{
			return _tag == value;
		}
		
		public function get convertDisplayObject():DisplayObject 
		{
			return this;
		}
		
		public function addTo(father:DisplayObjectContainer, floor:int = -1):INodeDisplay
		{
			if (floor < 0||floor >= father.numChildren)
			{
				father.addChild(this);
			}else{
				father.addChildAt(this,floor);
			}
			return this;
		} 
		
		public function removeFromParent(value:Boolean = true):void 
		{
			if (value) destroy();
			if (parent) parent.removeChild(this);
		}
		
		public function getKindFather():IKindSprite
		{
			return this.parent as IKindSprite;
		}
		
		/*
		 * 调度器
		 * */
		public function get scheduler():TickObserver
		{
			return new TickObserver(this);
		}
		
		public function stopScheduler(method:Function = null):void
		{
			if (method is Function) {
				TickManager.getInstance().removeMethod(this, method);
			}else {
				TickManager.getInstance().removeTarget(this);
			}
		}
		//end
	}

}