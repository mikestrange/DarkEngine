package org.sdk.display.core 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.sdk.display.QuickHandler;
	import org.sdk.display.tick.Ticker;
	import org.sdk.interfaces.IBaseSprite;
	import org.sdk.interfaces.INodeDisplay;
	import org.sdk.interfaces.IObject;
	import org.sdk.interfaces.ITicker;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class BaseSprite extends InternalSprite implements IBaseSprite 
	{
		private var _tag:int;
		private var _sizeWidth:Number;
		private var _sizeHeight:Number;
		private var _ticker:Ticker;
		private var _delegate:IObject;
		
		public function BaseSprite() 
		{
			
		}
		
		/*初始化*/
		protected function initialization():void
		{
			
		}
		
		/* INTERFACE org.sdk.interfaces.IBaseSprite */
		public function addNodeDisplay(node:INodeDisplay, floor:int = -1, tag:int = 0):INodeDisplay
		{
			node.setTag(tag);
			if(floor < 0 || floor >= this.numChildren)
			{
				addChild(node.convertDisplayObject);
			}else{
				addChildAt(node.convertDisplayObject, floor);
			}
			return node;
		}
		
		public function removeEveryChildren():void 
		{
			while (this.numChildren) {
				QuickHandler.cleanupDisplayObject(this.removeChildAt(0), true);
			}
		}
		
		public function removeByName(childName:String):DisplayObject 
		{
			const dis:DisplayObject = getChildByName(childName);
			if (dis) {
				this.removeChild(dis);
				QuickHandler.cleanupDisplayObject(dis, true);
			}
			return dis;
		}
		
		public function getChildByTag(tag:int):INodeDisplay 
		{
			for (var i:int = 0; i < this.numChildren; i++) {
				const dis:DisplayObject = getChildAt(i);
				if (isNodeDisplay(dis) && INodeDisplay(dis).isTag(tag)) 
				{
					return dis as INodeDisplay;
				}
			}
			return null;
		}
		
		public function get convertSprite():Sprite 
		{
			return this;
		}
		
		public function eachChildrenHandler(handler:Function, tag:int = 0):void 
		{
			const list:Vector.<INodeDisplay> = new Vector.<INodeDisplay>;
			for (var i:int = 0; i < this.numChildren; i++) {
				const dis:DisplayObject = getChildAt(i);
				if (isNodeDisplay(dis) && INodeDisplay(dis).isTag(tag)) 
				{
					list.push(dis as INodeDisplay);
				}
			}
			//处理
			for each(var node:INodeDisplay in list) 
			{
				handler(node);
			}
		}
		
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
		
		public function removeFromParent(value:Boolean = true):void 
		{
			if (value) undepute();
			if (parent) parent.removeChild(this);
		}
		
		public function get ticker():ITicker 
		{
			if (_ticker == null) _ticker = new Ticker();
			return _ticker;
		}
		
		public function removeTicker():void 
		{
			if (_ticker) {
				_ticker.unload();
				_ticker = null;
			}
		}
		
		public function get delegate():IObject
		{
			return _delegate;
		}
		
		public function set delegate(value:IObject):void	
		{
			_delegate = value;
		}
		
		public function applyHandler(notice:String, target:Object = null):void 
		{
			
		}
		
		public function undepute():void 
		{
			this.removeTicker();
			QuickHandler.cleanupDisplayObject(this);
		}
		
		public function getCodeName():String 
		{
			return null;
		}
		
		//end
	}

}