package org.sdk.key 
{
	import flash.utils.*;
	import flash.events.KeyboardEvent;
	import org.sdk.AppWork;
	
	final public class KeyManager 
	{
		private static var keyCodes:Dictionary = new Dictionary;
		private static var funList:Vector.<Function> = new Vector.<Function>;
		private static var isEnabled:Boolean;
		
		public static function setEnabled(value:Boolean):void
		{
			if (isEnabled == value) return;
			isEnabled = value;
			if (value) {
				AppWork.addStageListener(KeyboardEvent.KEY_DOWN, onKeyHandler);
				AppWork.addStageListener(KeyboardEvent.KEY_UP, onKeyHandler);
			}else {
				AppWork.removeStageListener(KeyboardEvent.KEY_DOWN, onKeyHandler);
				AppWork.removeStageListener(KeyboardEvent.KEY_UP, onKeyHandler);
			}
		}
		
		private static function onKeyHandler(event:KeyboardEvent):void
		{
			const code:uint = event.keyCode;
			const isDown:Boolean = (event.type == KeyboardEvent.KEY_DOWN);
			var node:KeyEvent = keyCodes[code];
			const prevIsDown:Boolean = node ? node.$isDown : false;
			//松开的时候直接删除
			if (isDown == false) delete keyCodes[code];
			//不能同时被响应
			if (isDown == prevIsDown) return;
			//按下的时候注册
			if (isDown && node == null) {
				node = new KeyEvent(code, true);
				keyCodes[code] = node;
			}
			node.$isDown = isDown;
			//广播事件
			const vector:Vector.<Function> = funList.slice(0, funList.length);
			for each(var hand:Function in vector) {
				hand(node);
			}
		}
		
		/*
		 * 清理非自己的按钮
		 * */
		public static function unClean(code:int = -1):void
		{
			for each(var node:KeyEvent in keyCodes) {
				if (node.getCode() == code) continue;
				node.$isDown = false;
			}
		}
		 
		/*
		 * 全局获取
		 * */
		public static function isKeyDown(code:uint):Boolean
		{
			return keyCodes[code] != undefined;
		}
		
		/*
		 * 获取按下时间
		 * */
		public static function getDownTime(code:uint):Number
		{
			const node:KeyEvent = keyCodes[code];
			if (node) return node.$downTime;
			return NaN;
		}
		
		/*
		 * 注册
		 * */
		public static function addKeyListener(called:Function):void
		{
			if (funList.indexOf(called) == -1) {
				funList.push(called);
			}
		}
		
		/*
		 * 删除
		 * */
		public static function removeKeyListener(called:Function):void
		{
			const index:int = funList.indexOf(called);
			if (index != -1) {
				funList.splice(index, 1);
			}
		}
		//ends
	}
}


