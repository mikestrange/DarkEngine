package org.sdk.display.com.selector 
{
	import flash.utils.Dictionary;
	import org.sdk.interfaces.IDelegate;
	/**
	 * 一个状态设置机，可以作为扩展
	 * @author Mike email:542540443@qq.com
	 */
	public class SelectedController implements IDelegate
	{
		private var itemMap:Dictionary;
		
		public function SelectedController() 
		{
			itemMap = new Dictionary;
		}
		
		/*
		 * 添加一个候选人
		 * */
		public function putSclecteds(key:String, defType:String = null):void
		{
			const item:SelectedData = getValue(key);
			if (item) {
				item.status = defType;
			}else {
				itemMap[key] = new SelectedData(key, defType);
			}
		}
		
		/*
		 * 根据键值，获取一个选择器
		 * */
		private function getValue(key:String):SelectedData
		{
			return itemMap[key];
		}
		
		/*
		 * 根据状态获取一个状态的集合
		 * */
		private function getValuesByStatus(type:String):Array
		{
			const list:Array = [];
			for each(var item:SelectedData in itemMap) {
				if (item.status == type)
				{
					list.push(item);
				}
			}
			return list;
		}
		
		/*
		 * 获取一个的状态
		 * */
		public function getStatus(key:String):String
		{
			const item:SelectedData = getValue(key);
			if (item) item.status;
			return null;
		}
		
		/*
		 *改变状态
		 * */
		public function updateStatus(key:String, type:String = null):void
		{
			const item:SelectedData = getValue(key);
			if (item) item.status = type;
		}
		
		/*
		 * 某个选择器选择移除的时候处理响应
		 * */
		public function removeSelected(key:String):void
		{
			if (hasSelected(key)) {
				delete itemMap[key];
			}
		}
		
		/*
		 * 存在一个选择器
		 * */
		public function hasSelected(key:String):Boolean
		{
			return itemMap[key] != undefined;
		}
		
		/*
		 * 获取一个状态的所有建，时间先后
		 * */
		public function getKeysByStatus(type:String):Vector.<String>
		{
			const list:Array = getValuesByStatus(type);
			list.sortOn("lastTime", Array.NUMERIC);
			const vector:Vector.<String> = new Vector.<String>;
			for (var i:int = 0; i < list.length; i++) {
				const item:SelectedData = list[i];
				trace(item.lastTime);
				vector.push(item.key);
			}
			return vector;
		}
		
		public function applyHandler(notice:String, target:Object = null):void
		{
			
		}
		//ends
	}
}

//****************************
import flash.utils.getTimer;

class SelectedData
{
	public var lastTime:uint;
	//
	private var _key:String;
	private var _status:String;
	
	public function SelectedData(key:String, status:String = null)
	{
		this._key = key;
		this._status = status;
		this.lastTime = getTimer();
	}
	
	public function get key():String
	{
		return _key;
	}
	
	public function set status(value:String):void
	{
		_status = value;
		lastTime = getTimer();
	}
	
	public function get status():String
	{
		return _status;
	}
	//end
}

