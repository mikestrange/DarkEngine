package org.sdk.load 
{
	import org.sdk.load.DownLoader;
	/**
	 * 回执事件
	 */
	public class LoadEvent 
	{
		public static const COMPLETE:String = "complete";
		public static const FAILED:String = "failed";
		public static const PROGRESS:String = "progress";
		//
		public var data:*= undefined;
		public var args:Object;
		public var type:String;
		public var target:DownLoader;
		
		public function LoadEvent(type:String, target:DownLoader, data:*= undefined, args:Object = null) 
		{
			this.type = type;
			this.target = target;
			this.data = data;
			this.args = args;
		}
		//ends
	}

}