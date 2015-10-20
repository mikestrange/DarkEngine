package org.sdk.interfaces 
{
	/**
	 * 相对于Bitmap,不过适合管理，需要资源管理，构造类实现：IVisitor就可以了
	 */
	public interface IRender extends IObject
	{
		/*
		 * 获取资源，直接渲染，渲染失败不做处理
		 * */
		function localRender(name:String, data:Object = null):void;
		/*
		 * 错误回执
		 * */
		function getFailedHandler(name:String, data:Object = null):IRefObject;
		/*
		 * 资源路径/或者资源名称
		 * */
		function getRefName():String;
		/*
		 * 设置材质，直接设置不会有问题
		 * */
		function washRender(target:IRefObject):void;
		/*
		 * 是否渲染，也就是否有材质
		 * */
		function isRender():Boolean;
		/*
		 * 复制
		 * */
		function clone():IRender;
		/*
		 * */
		function cleanRender():void;
		//ends
	}
	
}