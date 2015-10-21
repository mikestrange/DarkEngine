package org.sdk 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.UncaughtErrorEvent;
	import flash.system.ApplicationDomain;
	import org.sdk.debug.Log;
	import org.sdk.manager.SceneManager;
	import org.sdk.engine.MotivePower;
	import flash.display.InteractiveObject;
	import flash.utils.getDefinitionByName;
	import org.sdk.frame.made.PureListener;
	/**
	 * 程序入口
	 */
	public final class AppWork 
	{
		private static var _stage:Stage;
		
		public static function setApp(root:Sprite):void
		{
			addError(root);
			AppWork.stage = root.stage;
			AppWork.getSceneManager().root = root;
			MotivePower.setRunDispatcher(root);
		}
		
		private static function addError(target:Sprite):void
		{
			const errorHandler:Function = function(event:UncaughtErrorEvent):void
			{
				Log.error(event.error.getStackTrace());
			}
			target.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError", errorHandler);
		}
		
		public static function get stage():Stage
		{
			return _stage;
		}
		
		public static function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		public static function get stageWidth():Number
		{
			return _stage.stageWidth;
		}
		
		public static function get stageHeight():Number
		{
			return _stage.stageHeight;
		}
		
		public static function get frameRate():Number
		{
			return _stage.frameRate;
		}
		
		public static function addStageListener(type:String, called:Function):void
		{
			_stage.addEventListener(type, called);
		}
		
		public static function removeStageListener(type:String, called:Function):void
		{
			_stage.removeEventListener(type, called);
		}
		
		//设置焦点
		public static function setFocus(target:InteractiveObject = null):Boolean
		{
			if (target == null) {
				_stage.focus = _stage;
				return true;
			}
			if (target && target.stage) {
				_stage.focus = target;
				return true;
			}
			return false;
		}
		
		//实例化类，当前域下
		public static function getObject(name:String):*
		{
			try {
				const classObject:Class = getDefinitionByName(name) as Class;
				return new classObject();
			}catch (err:Error) {
				Log.debug("无法找到类：", name);
			}
			return null;
		}
		
		//通用消息
		protected static const notice:PureListener = new PureListener;
		
		public static function getSceneManager():SceneManager
		{
			return SceneManager.getInstance();
		}
		//end
	}

}