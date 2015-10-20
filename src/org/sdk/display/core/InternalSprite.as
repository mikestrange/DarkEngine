package org.sdk.display.core 
{
	import flash.display.Sprite;
	import org.sdk.interfaces.INodeDisplay;
	
	/**
	 * ...
	 * @author Main
	 */
	internal class InternalSprite extends Sprite 
	{
		
		public function InternalSprite() 
		{
			super();
		}
		
		//static
		protected static function isNodeDisplay(target:Object):Boolean
		{
			return target is INodeDisplay;
		}
		//ends
	}
}