package org.sdk.load 
{
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	/**
	 * 下载监听器
	 */
	public class DownLoader 
	{
		private static const NO_TIME:int = -1;
		//头
		protected var _url:String;
		protected var _priority:int;
		//传输
		protected var _complete:Function;
		protected var _args:Object;
		protected var _failed:Function;
		protected var _progress:Function;
		//时间 存在下载的时候会记录
		protected var _injectTime:int = NO_TIME;
		protected var _startTime:int = NO_TIME;
		protected var _completeTime:int = NO_TIME;
		//状态
		protected var _isLoad:Boolean;
		protected var _isKeep:Boolean;
		//重发次数
		protected var _repeatValue:int;
		/*
		 * 卸载当前回执和监听
		 * */
		public function unload():void
		{
			if (_isKeep) {
				QueueManager.getInstance().removeDownLoader(this);
				_isKeep = false;
			}
			_isLoad = false;
			_complete = null;
			_args = null;
			_failed = null;
			_progress = null;
		}
		
		/*
		 * 加入队列时间
		 * */
		public function getInjectTime():int
		{
			return _injectTime;
		}
		 
		/*
		 * 开始下载时间
		 * */
		public function getStartTime():int
		{
			return _startTime;
		}
		
		/*
		 * 结束时间
		 * */
		public function getCompleteTime():int
		{
			return _completeTime;
		}
		
		/*
		 * 下载消耗时间
		 * */
		public function getLoadExpendTime():int 
		{
			return _completeTime - _startTime;
		}
		
		/*
		 * 重新下载次数
		 * */
		public function getRepeatValue():int
		{
			return _repeatValue;
		}
		
		/*
		 * 队列中
		 * */
		public function isKeep():Boolean
		{
			return _isKeep;
		}
		
		/*
		 * 下载中
		 * */
		public function isLoading():Boolean
		{
			return _isLoad;
		}
		
		/*
		 * 下载地址
		 * */
		public function getURL():String
		{
			return _url;
		}
		 
		/*
		 * 优先级
		 * */
		public function get priority():int
		{
			return _priority;
		}
		
		/*
		 * 如果本地存在资源，那么可以判断下
		 * */
		public function load(url:String, complete:Function, args:Object = null, failed:Function = null, 
		progress:Function = null , priority:int = 0):void
		{
			if (_isKeep) {
				trace("已经被添加到队列中:", url);
				return;
			}
			_repeatValue = 0;
			_isKeep = true;
			_url = url;
			_priority = priority;
			_args = args;
			_failed = failed;
			_complete = complete;
			_progress = progress;
			_injectTime = getTimer();
			QueueManager.getInstance().put(this);
			QueueManager.getInstance().loadNext();
		}
		
		/*
		 * 重新下载
		 * */
		public function recurLoad():void
		{
			if (_url && !_isKeep) 
			{
				_repeatValue++;
				_isKeep = true;
				_injectTime = getTimer();
				_startTime = NO_TIME;
				_completeTime = NO_TIME;
				QueueManager.getInstance().put(this);
				QueueManager.getInstance().loadNext();
			}
		}
		
		/*
		 * 资源处理，这个时候资源已经缓存,根据资源的不同保存：所以，继承他就可以了 data==null的时候
		 * */
		public function assetHandler(assets:*= undefined):void
		{
			_isKeep = false;
			_isLoad = false;
			_completeTime = getTimer();
		}
		
		/*
		 *这里是为了做本地监听----------------
		 * */
		internal function start():void
		{
			_isLoad = true;
			_startTime = getTimer();
		}
		
		internal function onComplete(data:*= undefined):void
		{
			if (_complete is Function) {
				_complete(new LoadEvent(LoadEvent.COMPLETE, this, data, _args));
			}
		}
		
		internal function onFailed():void
		{
			if (_failed is Function) {
				_failed(new LoadEvent(LoadEvent.FAILED, this, null, _args));
			}
		}
		
		internal function onProgress(event:Object = null):void
		{
			if (_progress is Function) {
				_progress(new LoadEvent(LoadEvent.PROGRESS, this, event, _args));
			}
		}
		
		//static
		public static function create(url:String, complete:Function):DownLoader
		{
			const loader:DownLoader = new DownLoader;
			loader.load(url, complete, null, complete);
			return loader;
		}
		
		//ends
	}

}