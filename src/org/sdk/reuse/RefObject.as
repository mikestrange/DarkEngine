package org.sdk.reuse 
{
	import org.sdk.interfaces.IObject;
	import org.sdk.interfaces.IRefObject;

	/**
	 * 缓存的对象，默认不保存
	 * @author Mike email:542540443@qq.com
	 */
	public class RefObject implements IRefObject 
	{
		protected var _name:String;
		protected var _target:*= undefined;
		protected var _count:uint = 0;
		private var _delegate:IObject;
		
		public function RefObject(name:String, target:*= undefined) 
		{
			this._name = name;
			this._target = target;
			this.bind();
		}
		
		/* INTERFACE org.sdk.interfaces.IDevelop */
		private function bind():void
		{
			RefManager.getInstance().addRef(this);
		}
		
		public function release():void
		{
			_count--;
			if (_count == 0) undepute();
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
		
		/* INTERFACE org.sdk.interfaces.IObject */
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
		
		//摧毁-释放调用
		public function undepute():void
		{
			RefManager.getInstance().remove(_name);
		}
		
		//唯一名称
		public function getCodeName():String
		{
			return _name;
		}
		
		//end
	}

}