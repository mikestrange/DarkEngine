package org.sdk.display.core 
{
	import flash.display.BitmapData;
	import org.sdk.AppWork;
	import org.sdk.display.tick.Ticker;
	import org.sdk.interfaces.IBitmap;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.interfaces.ITicker;
	import flash.display.DisplayObject;
	import org.sdk.interfaces.INodeDisplay;
	import org.sdk.reuse.RefObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class MapSheet extends InternalRender implements IBitmap 
	{
		private var _sizeWidth:Number;
		private var _sizeHeight:Number;
		private var _tag:int;
		private var _ticker:Ticker;
		
		public function MapSheet(res:String=null) 
		{
			super(res);	
		}
		
		override public function getFailedHandler(name:String, data:Object = null):IRefObject 
		{
			const bit:BitmapData = AppWork.getObject(name) as BitmapData;
			if (bit) return new RefObject(name, bit);
			return super.getFailedHandler(name, data);
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
		
		public function setSize(wide:Number, heig:Number):void 
		{
			this._sizeWidth = wide;
			this._sizeHeight = heig;
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
		
		public function show():void 
		{
			this.visible = true;
		}
		
		public function hide():void 
		{
			this.visible = false;
		}
		
		public function get convertDisplayObject():DisplayObject 
		{
			return this;
		}
		
		public function addTo(father:DisplayObjectContainer,floor:int=-1):INodeDisplay
		{
			if(floor<0||floor>=father.numChildren){
				father.addChild(this);
			}else{
				father.addChildAt(this,floor);
			}
			return this;
		} 
		
		public function removeFromParent(value:Boolean = true):void 
		{
			if (value) undepute();
			if (parent) parent.removeChild(this);
		}
		
		public function get ticker():ITicker 
		{
			if (_ticker == null) _ticker = new Ticker;
			return _ticker;
		}
		
		public function removeTicker():void 
		{
			if (_ticker) {
				_ticker.unload();
				_ticker = null;
			}
		}
		
		//end
	}

}