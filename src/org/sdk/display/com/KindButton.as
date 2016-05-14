package org.sdk.display.com 
{
	import flash.events.MouseEvent;
	
	import org.sdk.display.DelegateDefined;
	import org.sdk.display.core.KindNode;
	import org.sdk.display.core.KindSprite;
	import org.sdk.interfaces.INodeDisplay;
	import org.sdk.interfaces.IRender;
	
	/**
	 * 按钮的基类
	 */
	public class KindButton extends KindSprite 
	{
		public static const NORMAL:String = "normal";
		public static const OVER:String = "over";
		public static const DOWN:String = "down";
		public static const RELEASE:String = "release";
		public static const LOCK:String = "lock";
		//
		private var _content:KindNode;
		private var _isOver:Boolean;
		private var _isDown:Boolean;
		private var _isLock:Boolean;
		
		public function KindButton()
		{
			this.initialization();
		}
		
		override protected function initialization():void 
		{
			super.initialization();
			if (null == _content) 
			{
				_content = new KindNode;
				this.addChild(_content.convertDisplayObject);
			}
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouse);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouse);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onAction);
			this.addEventListener(MouseEvent.MOUSE_UP, onAction);
			//设置初始状态
			onStatus(NORMAL);
		}
		
		override public function destroy():void 
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouse);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouse);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onAction);
			this.removeEventListener(MouseEvent.MOUSE_UP, onAction);
			super.destroy();
		}
		
		private function onMouse(event:MouseEvent):void
		{
			_isOver = event.type == MouseEvent.MOUSE_OVER;
			if (event.type == MouseEvent.MOUSE_OVER) {
				onStatusHandler(OVER);
			}else {
				onStatusHandler(NORMAL);
			}
		}
		
		private function onAction(event:MouseEvent):void
		{
			_isDown = event.type == MouseEvent.MOUSE_DOWN;
			if (event.type == MouseEvent.MOUSE_DOWN) {
				onStatusHandler(DOWN);
			}else {
				if (_isOver) {
					onStatusHandler(RELEASE);
					onClickHandler();
				}else {
					onStatusHandler(NORMAL);
				}
			}
		}
		
		public function get isOver():Boolean
		{
			return _isOver;
		}
		
		public function get isDown():Boolean
		{
			return _isDown;
		}
		
		private function onStatusHandler(type:String):void
		{
			if (!_isLock) onStatus(type)
		}
		
		/*
		 * 子类复写，这里只是转换过程
		 * */
		protected function onStatus(type:String):void
		{
			if (type == DOWN) setImage("btn_b_down");
			if (type == NORMAL) setImage("btn_b_keep");
			if (type == OVER) setImage("btn_b_over");
			if (type == RELEASE) setImage("btn_b_keep");
		}
		
		/*
		 * 处理点击事件
		 * */
		protected function onClickHandler():void
		{
			if(this.delegate){
				this.delegate.applyHandler(org.sdk.display.DelegateDefined.BUTTON_CLICK,this);
			}
		}
		
		/*
		 * 直接定义
		 * */
		public function setImage(className:String):void
		{
			if (_content) {
				_content.localRender(className);
			}
		}
		
		/*
		 * 皮肤描叙
		 * */
		public function get content():KindNode
		{
			return _content;
		}
		
		/*
		 * 锁定后，自身不能被事件改变皮肤
		 * */
		public function lock():void
		{
			_isLock = true;
			onStatus(LOCK);
		}
		
		/*
		 * 解锁后才能改变
		 * */
		public function unlock():void
		{
			_isLock = false;
		}
		
		//ends
	}

}