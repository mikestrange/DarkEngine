package org.sdk.display.com 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import org.sdk.display.com.item.Cell;
	
	import org.sdk.AppWork;
	import org.sdk.classes.common.MapInteger;
	import org.sdk.display.core.KindSprite;
	import org.sdk.display.com.interfaces.ITableViewDelegate;
	/**
	 * 拉动组件
	 */
	public class TableView extends KindSprite 
	{
		private static const NONE:int = 0;
		//判断是否移动的阔值
		private const MOVE_THRESHOLD:int = 5;
		//离心率
		private const _eccentricity:Number = .02;	
		//鼠标的位置
		private var _downMousePosition:Number;		
		//content按下的位置
		private var _downContentPosition:Number;			
		//按下时间
		private var _downTime:int;					
		//鼠标按下
		private var _isMouseDown:Boolean;
		//鼠标移动了
		private var _isMouseMove:Boolean;
		//
		private var _totalHeight:int;
		private var _spaceList:Vector.<Number>;
		//
		private var _cellMap:MapInteger;
		private var _content:KindSprite;
		private var _mask:Shape;
		
		public function TableView(wide:Number = 0, high:Number = 0)
		{
			setSize(wide, high);
		}
		
		override public function setSize(wide:Number, heig:Number):void 
		{
			super.setSize(wide, heig);
			//建立遮罩
			if (_mask == null) {
				_mask = new Shape;
				this.addChild(_mask);
			}
			_mask.graphics.clear();
			_mask.graphics.beginFill(0,.3);
			_mask.graphics.drawRect(0, 0, wide, heig);
			_mask.graphics.endFill();
			content.mask = _mask;
			//
			addListener();
		}
		
		private function addListener():void
		{
			removeListener();
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onSelfDown);
			AppWork.addStageListener(MouseEvent.MOUSE_MOVE, _onStageMove);
			AppWork.addStageListener(MouseEvent.MOUSE_UP, _onStageUp);
		}
		
		private function removeListener():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, _onSelfDown);
			AppWork.removeStageListener(MouseEvent.MOUSE_MOVE, _onStageMove);
			AppWork.removeStageListener(MouseEvent.MOUSE_UP, _onStageUp);
			_isMouseMove = _isMouseDown = false;
		}
		
		private function _onSelfDown(event:MouseEvent):void
		{
			_isMouseDown = true;
			_isMouseMove = false;
			_downTime = getTimer();
			_downMousePosition = AppWork.stage.mouseY;
			_downContentPosition = locationPosition;
		}
		
		private function _onStageUp(event:MouseEvent):void
		{
			_isMouseDown = false;
			const tickTime:int = getTimer() - _downTime;
			const interval:Number = AppWork.stage.mouseY - _downMousePosition;
		}
		
		private function _onStageMove(e:MouseEvent):void
		{
			if (_isMouseDown)
			{
				if (Math.abs(AppWork.stage.mouseY - _downMousePosition) > MOVE_THRESHOLD) _isMouseMove = true;
				//
				var endy:Number = _downContentPosition + (AppWork.stage.mouseY - _downMousePosition);
				if (endy > NONE) {
					endy = NONE;
				}else if (endy < -maxPosition) {
					endy = -maxPosition;
				}
				locationPosition = endy;
			}
		}
		
		/*
		 * 重置数据
		 * */
		public function reallocated():void
		{
			const lineLen:int = tableViewDelegate.rowHandler();
			_spaceList = new Vector.<Number>(lineLen, true);
			_totalHeight = NONE;
			for (var i:int = 0; i < lineLen; i++) {
				const space:Number = tableViewDelegate.spaceHandler(i);
				_spaceList[i] = _totalHeight;
				_totalHeight += space;
			}
			//-----
			_cellMap = null;
			if (_content) {
				_content.removeEveryChildren();
			}
			updateRender();
		}
		
		//value是一个正直
		protected function updateRender():void
		{
			//得到一个正位置
			const point:int = -locationPosition;
			const lineLen:int = _spaceList.length;
			//开始的位置
			var startIndex:int = NONE; 
			//偏移长度
			var offset:Number = NONE;	
			var i:int = NONE;
			if (point > NONE) {
				for (i = lineLen - 1; i >= NONE; i--) 
				{
					if (_spaceList[i] <= point) 
					{
						startIndex = i;
						offset = point - _spaceList[i];
						break;
					}
				}
			}else {
				startIndex = NONE;
				offset = point;
			}
			//渲染
			const maxHeight:int = sizeHeight + offset;
			const spaceTotal:Number = _spaceList[startIndex];
			if (point < _totalHeight) {
				for (i = startIndex; i < lineLen; i++) 
				{
					//trace(_spaceList[floor], spaceTotal, maxHeight);
					if (_spaceList[i] - spaceTotal >= maxHeight) break;
					if (tableMap.isKey(i)) {
						Cell(tableMap.getValue(i)).setOpen(true);
					}else {
						const item:Cell = tableViewDelegate.rollHandler(this, i);
						tableMap.put(i, item);
						item.setPosition(NONE, _spaceList[i]);
						item.setOpen(true);
						content.addChild(item.convertDisplayObject);
					}
				}	
			}
			refresh();
		}
		
		private function refresh():void
		{
			//重绘
			const renders:Function = function(item:Cell):void
			{
				if (item.isOpen()) {
					item.setOpen(false);
				}else {
					tableMap.remove(item.floor);
					item.removeFromParent();
				}
			}
			tableMap.eachValue(renders);
		}
		
		private function get tableMap():MapInteger
		{
			if(null == _cellMap) _cellMap = new MapInteger();
			return _cellMap;
		}
		
		public function getQueue(index:int = 0):Cell
		{
			return new Cell(index);
		}
		
		/*
		 * 是否滚动
		 * */
		public function get isMove():Boolean
		{
			return _isMouseMove;
		}
		
		/*
		 * 总高
		 * */
		public function get totalHeight():Number
		{
			return _totalHeight;
		}
		
		/*
		 * 内容
		 * */
		public function get content():Sprite
		{
			if (_content == null) {
				_content = new KindSprite;
				this.addNodeDisplay(_content);
			}
			return _content.convertSprite;
		}
		
		/*
		 * 位置的一个比例值
		 * */
		public function get ratio():Number
		{
			return Math.abs(locationPosition / maxPosition);
		}
		
		/*
		 * 最大的一个位置，超过尺寸为正
		 * */
		public function get maxPosition():Number
		{
			return _totalHeight - sizeHeight;
		}
		
		/*
		 * 设置位置，刷新视图
		 * */
		public function set locationPosition(value:int):void
		{
			content.y = value;
			updateRender();
		}
		
		/*
		 * 获取位置
		 * */
		public function get locationPosition():int
		{
			return  content.y;
		}
		
		/*
		 * 真正的委托者
		 * */
		public function get tableViewDelegate():ITableViewDelegate
		{
			return this.delegate as ITableViewDelegate;
		}
		
		override public function destroy():void
		{
			this.removeListener();
			super.destroy();
		}
		
		//ends
	}

}