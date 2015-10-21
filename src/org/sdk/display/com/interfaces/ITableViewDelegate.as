package org.sdk.display.com.interfaces 
{
	import org.sdk.display.com.scroll.Cell;
	import org.sdk.display.com.scroll.TableView;
	import org.sdk.interfaces.IDelegate;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public interface ITableViewDelegate extends IDelegate
	{
		function rowHandler():int;
		function spaceHandler(index:int):int;
		function rollHandler(table:TableView, floor:int):Cell;
		//ends
	}
	
}