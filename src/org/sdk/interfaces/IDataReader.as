package org.sdk.interfaces {
	/**
	 * 解析数据一种格式
	 * @author Mike email:542540443@qq.com
	 */
	public interface IDataReader 
	{
		//解析
		function unpack(data:*, mode:String = null):void;
		//得到的数据
		function get data():*;
		//加密
		function packing():*;
		//
	}
	
}