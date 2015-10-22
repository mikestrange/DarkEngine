package org.sdk.display 
{
	import flash.utils.getQualifiedClassName;
	import org.sdk.display.core.KindSprite;
	import org.sdk.manager.interfaces.IScene;
	import org.sdk.manager.SceneManager;
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class KindScene extends KindSprite implements IScene 
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