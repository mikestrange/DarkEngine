package org.sdk.key 
{
	import org.sdk.interfaces.IDelegate;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public interface IKeyDelegate extends IDelegate
	{
		function onKeyDownHandler(code:uint):void;
		function onKeyUpHandler(event:KeyEvent):void;
		//end
	}
	
}