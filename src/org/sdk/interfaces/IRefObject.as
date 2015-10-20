package org.sdk.interfaces 
{
	/**
	 * 一个IDE，被内存管理
	 * @author Mike email:542540443@qq.com
	 */
	public interface IRefObject extends IObject
	{
		function release():void;
		function ration():void;
		function get name():String;
		function get refCount():uint;
		function get target():*;
		function set target(value:*):void;
		//ends
	}
	
}