package org.sdk.load 
{
	/**
	 * 一个下载节点
	 */
	public class NodeLoader 
	{
		public var url:String;
		public var priority:int;
		private var _resloader:IResLoader;
		private var loadVector:Vector.<DownLoader>;
		
		public function NodeLoader(url:String, priority:int = 0) 
		{
			this.url = url;
			setPriority(priority);
			loadVector = new Vector.<DownLoader>;
		}
		
		public function setPriority(value:int):void
		{
			this.priority = value;
		}
		
		public function addDownLoader(loader:DownLoader):void 
		{
			const index:int = indexOf(loader);
			if (index == -1) loadVector.push(loader);
		}
		
		public function removeDownLoader(loader:DownLoader):Boolean
		{
			const index:int = indexOf(loader);
			if (index != -1) {
				loadVector.splice(index, 1);
			}
			return index != -1;
		}
		
		public function indexOf(loader:DownLoader):int
		{
			return loadVector.indexOf(loader);
		}
		
		public function isEmpty():Boolean
		{
			return loadVector.length == 0;
		}
		
		public function cleanAndClose():void
		{
			if (!isEmpty()) {
				const vector:Vector.<DownLoader> = loadVector;
				loadVector = new Vector.<DownLoader>;
				for each(var loader:DownLoader in vector) {
					loader.unload();
				}
			}
			//关闭下载器
			if (_resloader) {
				_resloader.finalize();
				_resloader = null;
			}
		}
		
		public function isLoad():Boolean
		{
			return _resloader != null;
		}
		
		public function get length():int
		{
			return loadVector.length;
		}
		
		/*
		 * 开始下载，通知所有成员
		 * */
		internal function loadBegin(resloader:IResLoader):void
		{
			if (_resloader) _resloader.finalize();
			_resloader = resloader;
			//通知所有人下载
			for each(var loader:DownLoader in loadVector) loader.start();
		}
		
		/*
		 * 下载完成的回调，不做错误处理
		 * 下载完成，清理所有的下载函数
		 * */
		internal function loadFinish(resloader:IResLoader):void
		{
			_resloader = null;
			if (loadVector.length) 
			{
				const vector:Vector.<DownLoader> = loadVector;
				loadVector = new Vector.<DownLoader>;
				for each(var loader:DownLoader in vector) 
				{
					loader.assetHandler(resloader.data);
					if (resloader.isError) 
					{
						loader.onFailed();
					}else {
						loader.onComplete(resloader.data);
					}
				}
			}
		}
		
		//进度处理
		public function loadProgress(event:Object):void
		{
			if (loadVector.length) 
			{
				for each(var loader:DownLoader in loadVector) 
				{
					loader.onProgress(event);
				}
			}
		}
		//end
	}

}