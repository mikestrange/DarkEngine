package org.sdk.key 
{
	import flash.utils.*;
	import flash.events.KeyboardEvent;
	import org.sdk.AppWork;
	
	final public class KeyManager 
	{
		private static var keyCodes:Dictionary = new Dictionary;
		private static var delegateList:Vector.<IKeyDelegate>;
		private static var isEnabled:Boolean;
		private static const NONE:int = 0;
		
		public static function setEnabled(value:Boolean):void
		{
			if (isEnabled == value) return;
			isEnabled = value;
			if (value) {
				if (null == delegateList) delegateList = new Vector.<IKeyDelegate>;
				AppWork.addStageListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
				AppWork.addStageListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			}else {
				AppWork.removeStageListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
				AppWork.removeStageListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
				/*
				 * 这里要不要通知那些按下的键
				 * */
				KeyManager.unclasp(); 
			}
		}
		
		private static function onKeyDownHandler(event:KeyboardEvent):void
		{
			const code:uint = event.keyCode;
			if (isKeyDown(code)) return;
			keyCodes[code] = new KeyEvent(code);
			if (delegateList.length) {
				const list:Vector.<IKeyDelegate> = delegateList.slice(NONE, delegateList.length);
				for each(var delegate:IKeyDelegate in list) {
					delegate.onKeyDownHandler(code);
				}
			}
		}
		
		private static function onKeyUpHandler(event:KeyboardEvent):void
		{
			const code:uint = event.keyCode;
			const node:KeyEvent = keyCodes[code];
			if (node) delete keyCodes[code];
			if (delegateList.length) {
				const list:Vector.<IKeyDelegate> = delegateList.slice(NONE, delegateList.length);
				for each(var delegate:IKeyDelegate in list) 
				{
					delegate.onKeyUpHandler(node);
				}
			}
		}
		
		/*
		 * 非当前按键，其他按键松开状态
		 * */
		public static function unclasp(code:int = -1):void
		{
			for each(var node:KeyEvent in keyCodes) 
			{
				if (node.code == code) continue;
				delete keyCodes[node.code];
			}
		}
		 
		/*
		 * 判断一个按键是否按下
		 * */
		public static function isKeyDown(code:uint):Boolean
		{
			return keyCodes[code] != undefined;
		}
		
		/*
		 * 获取一个按键按下的信息
		 * */
		public static function getDownInfo(code:uint):KeyEvent
		{
			return keyCodes[code];
		}
		
		/*
		 * 注册委托
		 * */
		public static function addKeyListener(delegate:IKeyDelegate):void
		{
			if (delegateList.indexOf(delegate) == -1) {
				delegateList.push(delegate);
			}
		}
		
		/*
		 * 删除委托
		 * */
		public static function removeKeyListener(delegate:IKeyDelegate):void
		{
			const index:int = delegateList.indexOf(delegate);
			if (index != -1) {
				delegateList.splice(index, 1);
			}
		}
		//ends
	}
}


