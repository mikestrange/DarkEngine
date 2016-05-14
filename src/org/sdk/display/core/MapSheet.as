package org.sdk.display.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.sdk.interfaces.IDelegate;
	import org.sdk.interfaces.IObject;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.interfaces.IRender;
	import org.sdk.manager.RefManager;
	
	/**
	 * 这个只是贴图，不存在任何,作为私有
	 * @author Mike email:542540443@qq.com
	 */
	internal class MapSheet extends Bitmap implements IRender 
	{
		private var _delegate:IDelegate;
		private var _ref:IRefObject;
		
		public function MapSheet(res:String = null) 
		{
			super();
			if (res) localRender(res);
		}
		
		protected function setTexture(target:*):void
		{
			if(target == null) return;
			if (target is BitmapData) {
				this.bitmapData = target;
			}else if(target is Bitmap){
				this.bitmapData = Bitmap(target).bitmapData;
			}else{
				this.bitmapData = target["bitmapData"];
			}
			this.smoothing = true;
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
		
		public function washRender(target:IRefObject, data:Object = null):void 
		{
			if (target && target != _ref) 
			{
				target.ration();
				if (_ref) _ref.release();
				_ref = target;
				//setTexture(_ref.target);
				updateRender(_ref.target, data);
			}
		}
		
		//子类重写
		protected function updateRender(target:*, data:Object):void
		{
			
		}
		
		public function isRender():Boolean 
		{
			return _ref != null;
		}
		
		public function cleanRender():void 
		{
			this.bitmapData = null;
			if (_ref) {
				_ref.release();
				_ref = null;
			}
		}
		
		/* INTERFACE org.sdk.interfaces.IObject */
		public function get delegate():IDelegate
		{
			return _delegate;
		}
		
		public function set delegate(value:IDelegate):void	
		{
			_delegate = value;
		}
		
		public function applyHandler(notice:String, target:Object = null):void 
		{
			
		}
		
		public function destroy():void 
		{
			cleanRender();
		}
		
		//ends
	}

}