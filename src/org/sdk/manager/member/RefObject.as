package org.sdk.manager.member 
{
	import flash.display.BitmapData;
	import org.sdk.manager.RefManager;
	import org.sdk.display.QuickHandler;
	import org.sdk.interfaces.IRefObject;
	import org.sdk.beyond_abysm;
	use namespace beyond_abysm;
	/**
	 * 缓存的对象，默认保存
	 * @author Mike email:542540443@qq.com
	 */
	public class RefObject implements IRefObject 
	{
		protected var _name:String;
		protected var _target:*= undefined;
		protected var _count:uint = 0;
		
		public function RefObject(name:String, target:*= undefined) 
		{
			this._name = name;
			this._target = target;
			this.bind();
		}
		
		protected function bind():void
		{
			RefManager.getInstance().addRef(this);
		}
		
		/* INTERFACE org.sdk.interfaces.IDevelop */
		public function release():void
		{
			_count--;
			if (_count <= 0) finality();
		} 
		
		public function ration():void
		{
			_count++;
		}
		
		public function get refCount():uint
		{
			return _count;
		}
		
		public function get target():*
		{
			return _target;
		}
		
		public function set target(value:*):void
		{
			_target = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function finality():void
		{
			RefManager.getInstance().remove(_name);
			if(_target is BitmapData){
				QuickHandler.cleanupBitmapdata(_target);
				_target = null;
			}
		}
		
		//end
	}

}