package org.sdk.display.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.sdk.interfaces.IObject;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.interfaces.IRender;
	import org.sdk.reuse.RefManager;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	internal class InternalRender extends Bitmap implements IRender 
	{
		private var _delegate:IObject;
		private var _ref:IRefObject;
		
		public function InternalRender(res:String = null) 
		{
			super();
			if (res) localRender(res);
		}
		
		protected function setTexture(target:*):void
		{
			if (target is BitmapData) {
				this.bitmapData = target;
				this.smoothing = true;
			}
		}
		
		final protected function hasRef(name:String):Boolean
		{
			return RefManager.getInstance().hasRef(name);
		}
		
		/* INTERFACE org.sdk.interfaces.IRender */
		public function localRender(name:String, data:Object = null):void 
		{
			RefManager.getInstance().applyTo(this, name, data);
		}
		
		public function getFailedHandler(name:String, data:Object = null):IRefObject 
		{
			return null;
		}
		
		public function getRefName():String 
		{
			if (_ref) return _ref.name;
			return null;
		}
		
		public function washRender(target:IRefObject):void 
		{
			if (target && target != _ref) 
			{
				target.ration();
				if (_ref) _ref.release();
				_ref = target;
				setTexture(_ref.target);
			}
		}
		
		public function isRender():Boolean 
		{
			return _ref != null;
		}
		
		public function clone():IRender 
		{
			const RenderClass:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			const target:IRender = new RenderClass;
			if (isRender()) {
				target.washRender(_ref);
			}
			return target;
		}
		
		public function cleanRender():void 
		{
			this.bitmapData = null;
			if (_ref) {
				_ref.release();
				_ref = null;
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
			cleanRender();
		}
		
		public function getCodeName():String 
		{
			return null;
		}
		
		//ends
	}

}