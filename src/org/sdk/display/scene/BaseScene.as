package org.sdk.display.scene 
{
	import flash.utils.getQualifiedClassName;
	import org.sdk.display.core.BaseSprite;
	import org.sdk.frame.made.PureListener;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class BaseScene extends BaseSprite implements IScene 
	{	
		/* INTERFACE org.sdk.display.scene.IScene */
		public function getSceneName():String 
		{
			return getQualifiedClassName(this);
		}
		
		public function onEnter(data:* = undefined):void 
		{
			SceneManager.getInstance().root.addChild(this);
		}
		
		public function onExit():void 
		{
			this.removeFromParent();
		}
		
		protected function closeSelf():void
		{
			SceneManager.getInstance().closeScene(this);
		}
		//ends
	}

}