package org.sdk.load 
{
	
	/**
	 * 资源下载器...
	 * @author Mike email:542540443@qq.com
	 */
	public interface IResLoader 
	{
		function downLoad(url:String, context:*= undefined):void;
		function finalize():void;
		function get url():String;
		function get data():*;
		function get isError():Boolean;
		//end
	}
	
}