package org.sdk.load 
{
	import flash.utils.Dictionary;
	import org.sdk.debug.Log;
	import org.sdk.load.loads.LoadManager;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class QueueManager 
	{
		private static const NONE:int = 0;
		//全局
		private static var _ins:QueueManager;
		
		public static function getInstance():QueueManager
		{
			return _ins || (_ins = new QueueManager);
		}
		
		public function QueueManager()
		{
			_requests = [];
			_queueMap = new Dictionary;
			LoadManager.setDefault();
		}
		
		//列表和表
		private var _requests:Array;
		private var _queueMap:Dictionary;
		//
		private var _maxLen:int = 1;
		private var _loadLen:int = 0;
		
		//他只关心下载的Url，不关心处理
		public function put(loader:DownLoader):void
		{
			const url:String = loader.getURL();
			var node:NodeLoader = getNode(url);
			if (null == node) {
				node = new NodeLoader(url, loader.priority);
				_requests.push(node);
				_queueMap[url] = node;
				Log.debug("添加下载@", url);
			}else {
				node.setPriority(loader.priority);
			}
			node.addDownLoader(loader);
		}
		
		//priority值越大越在前面
		public function sort():void
		{
			_requests.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		}
		
		public function getLoadLength():int
		{
			return _loadLen;
		}
		
		public function isLoadFull():Boolean 
		{
			return 	_loadLen >= _maxLen;
		}
		
		public function isWaitEmpty():Boolean
		{
			return _requests.length == NONE;
		}
		
		public function loadNext():void
		{
			if (isWaitEmpty()) {
				Log.debug("等待下载列表为空,目前下载个数:", _loadLen);
			}else if (isLoadFull()) {
				Log.debug("当前下载队列已满,目前等待下载个数:", _requests.length);
			}else {
				const node:NodeLoader = _requests.shift();
				if (isMap(node.url)) 
				{
					loadRise();
					const loader:IResLoader = createLoader(node.url);
					loader.downLoad(node.url);
					node.loadBegin(loader);
				}
				//继续下载
				loadNext();
			}
		}
		
		/*
		 * 下载回执
		 * */
		public function onLoadComplete(loader:IResLoader):void
		{
			const node:NodeLoader = removeNode(loader.url);
			//通知完成
			if (node) node.loadFinish(loader);
			//下载下一个
			loadNext();
		}
		
		/*
		 * 进度
		 * */
		public function onProgressHandler(url:String, event:Object = null):void
		{
			const node:NodeLoader = getNode(url);
			if (node) node.loadProgress(event);
		}
		
		/*
		 * 建立下载器
		 * */
		public function createLoader(url:String):IResLoader
		{
			return LoadManager.createDefLoader(url);
		}
		
		/*
		 * 上浮下载个数
		 * */
		private function loadRise():void 
		{
			_loadLen++;	
		}
		
		/*
		 * 下降下载个数
		 * */
		private function loadLower():void 
		{
			_loadLen--;	
		}
		
		/*
		 * 节点
		 * */
		public function getNode(url:String):NodeLoader
		{
			return _queueMap[url];
		}
		
		/*
		 * 是否在表中
		 * */
		public function isMap(url:String):Boolean
		{
			return _queueMap[url] != undefined;
		}
		
		/*
		 * 主动可以删除，下载完成和下注错误也要删除
		 * */
		public function removeNodeAndStop(url:String):void
		{
			const node:NodeLoader = removeNode(url);
			if (node) {
				//清理下载
				node.cleanAndClose();
				//下载下一个
				loadNext();
			}
		}
		
		/*
		 * 移除，不清理监听器，等下一个函数处理
		 * */
		private function removeNode(url:String):NodeLoader
		{
			const node:NodeLoader = getNode(url);
			if (node) {
				_queueMap[url] = null;
				delete _queueMap[url];
				Log.debug("移除下载@", url);
				if (node.isLoad()) loadLower();
			}
			return node;
		}
		
		/*
		 * 移除一个下载监听器
		 * */
		public function removeDownLoader(loader:DownLoader):void
		{
			const node:NodeLoader = getNode(loader.getURL());
			if (node) {
				node.removeDownLoader(loader);
				if (node.isEmpty()) {
					this.removeNodeAndStop(loader.getURL());
				}
			}
		}
		
		public function toString():String
		{
			var chat:String = "##ticker->start";
			for each(var node:NodeLoader in _queueMap) {
				chat += "\nnode:[";
				chat += "url = " + node.url + ", ";
				chat += "priority = " + node.priority + ", ";
				chat += "length = " + node.length + ", ";
				chat += "isload = " + node.isLoad();
				chat += "]";
			}
			chat += "\n##ticker->end";
			return chat;
		}
		//ends
	}
}