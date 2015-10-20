package org.sdk.display.com.scroll 
{
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import org.sdk.AppWork;
	import org.sdk.classes.common.MapInteger;
	import org.sdk.display.com.BaseComponent;
	import org.sdk.display.com.interfaces.ICell;
	import org.sdk.display.core.BaseSprite;
	import org.sdk.interfaces.IBaseSprite;
	/**
	 * 
	 */
	public class TableView extends BaseComponent 
	{
		private static const NONE:int = 0;
		//
		private const _eccentricity:Number = .02;	//离心率
		private var _downY:int;						//开始位置
		private var _currentY:int;					//当前的移动距离
		private var _downTime:int;					//按下时间
		private var moveDistance:Number = 0;		//移动距离
		//动态
		private var _isDown:Boolean;
		private var _isMove:Boolean;
		private var _isSelfMove:Boolean;
		//
		private var _lineLen:int;
		private var _totalHeight:int;
		private var _rollApply:Function;
		private var _spaceList:Vector.<Number>;
		//
		private var _itemMap:MapInteger;
		private var _loader:IBaseSprite;
		private var _mask:Shape;
		
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
			getLoader().mask = _mask;
			//
			addListener();
		}
		
		public function cleanContent():void
		{
			_itemMap = null;
			if(_loader){
				_loader.removeEveryChildren();
			}
		}
		
		private function addListener():void
		{
			removeListener();
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onDown);
			AppWork.addStageListener(MouseEvent.MOUSE_MOVE, _onStageMove);
			AppWork.addStageListener(MouseEvent.MOUSE_UP, _onStageUp);
		}
		
		private function removeListener():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, _onDown);
			AppWork.removeStageListener(MouseEvent.MOUSE_MOVE, _onStageMove);
			AppWork.removeStageListener(MouseEvent.MOUSE_UP, _onStageUp);
			_isMove = _isDown = false;
		}
		
		override public function undepute():void
		{
			this.removeListener();
			super.undepute();
		}
		
		private function _onDown(e:MouseEvent):void
		{
			_isDown = true;
			_downTime = getTimer();
			_downY = AppWork.stage.mouseY;
			_currentY = _downY;
			_isMove = false;
			this.setRunning(true);
		}
		
		private function _onStageUp(e:MouseEvent):void
		{
			this.setRunning(false);
			this._isDown = false;
			this.moveDistance = NONE;
			this.updateRender( -getFinger());
			const tickTime:int = getTimer() - _downTime;
			const interval:Number = AppWork.stage.mouseY - _downY;
		}
		
		override protected function frameRender(float:uint = 0):void 
		{
			if (moveDistance != NONE && _isSelfMove)
			{
				_isSelfMove = false;
				const endy:Number = getLoader().y + moveDistance;
				if(endy > NONE){
					getLoader().y = NONE;
				}else if(endy < sizeHeight - _totalHeight){
					getLoader().y = sizeHeight - _totalHeight;
				}else{
					getLoader().y = endy;
				}
				this.updateRender(-getFinger());
			}	
		}
		
		//mouse move
		private function _onStageMove(e:MouseEvent):void
		{
			if (_isDown)
			{
				_isSelfMove = true;
				if (Math.abs(_downY - AppWork.stage.mouseY) > 5) _isMove = true;
				//
				moveDistance = AppWork.stage.mouseY - _currentY;
				if (this.getFinger() > NONE && moveDistance > NONE) {
					moveDistance = (sizeHeight - this.getFinger()) * _eccentricity;
				}else if (isBottom && moveDistance < NONE) {
					moveDistance = -(_totalHeight - Math.abs(this.getFinger())) * _eccentricity;
				}
				//重新设置
				_currentY = AppWork.stage.mouseY;
			}
		}
		
		private function getLoader():Sprite
		{
			if (_loader == null) {
				_loader = new BaseSprite;
				this.addChild(_loader.convertSprite);
			}
			return _loader.convertSprite;
		}
		
		public function getFinger():int
		{
			return  getLoader().y;
		}
		
		/*
		 * 重置的时候必须要填写
		 * */
		public function resetting(line:int , spaceHandler:Function, rollHandler:Function):void
		{
			_lineLen = line;
			_rollApply = rollHandler;
			_spaceList = new Vector.<Number>(line, true);
			_totalHeight = NONE;
			for (var i:int = 0; i < line; i++) {
				const space:Number = spaceHandler(i);
				_spaceList[i] = _totalHeight;
				_totalHeight += space;
			}
			//
			updateRender();
		}
		
		//value是一个正直
		public function updateRender(value:int = 0):void
		{
			getLoader().y = -value;
			const point:int = value; 
			const loader:Sprite = getLoader();
			var startIndex:int = NONE;
			var offset:Number = NONE;
			if (point > NONE) {
				for (var i:int = _lineLen - 1; i >= NONE; i--) 
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
				for (var floor:int = startIndex; floor < _lineLen; floor++) 
				{
					//trace(_spaceList[floor], spaceTotal, maxHeight);
					if (_spaceList[floor] - spaceTotal >= maxHeight) break;
					if (getMap().isKey(floor)) {
						ICell(getMap().getValue(floor)).setOpen(true);
					}else {
						const item:ICell = _rollApply(this, floor) as ICell;
						getMap().put(floor, item);
						item.setPosition(NONE, _spaceList[floor]);
						item.setOpen(true);
						loader.addChild(item.convertDisplayObject); //不会重复添加
					}
				}	
			}
			refresh();
		}
		
		private function refresh():void
		{
			//重绘
			const renders:Function = function(item:ICell):void
			{
				if (item.isOpen()) {
					item.setOpen(false);
				}else {
					getMap().remove(item.floor);
					item.removeFromParent();
				}
			}
			getMap().eachValue(renders);
		}
		
		private function getMap():MapInteger
		{
			if(null == _itemMap) _itemMap = new MapInteger();
			return _itemMap;
		}
		
		public function getQueue(index:int = 0):ICell
		{
			return new Cell(index);
		}
		
		//是否滑动到底部
		public function get isBottom():Boolean
		{
			return Math.abs(getLoader().y) > _totalHeight - sizeHeight;
		}
		
		public function get isTop():Boolean
		{
			return getLoader().y == NONE;
		}
		
		//是否滚动
		public function get isMove():Boolean
		{
			return _isMove;
		}
		
		//ends
	}

}