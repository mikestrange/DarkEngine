package org.sdk.display.scene 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Main
	 */
	public class SceneManager 
	{
		private static var _instance:SceneManager;
		
		public static function getInstance():SceneManager
		{
			if (null == _instance) {
				_instance = new SceneManager;
			}
			return _instance;
		}
		
		private var _root:Sprite;
		private var sceneList:Vector.<IScene>;
		
		public function SceneManager() 
		{
			sceneList = new Vector.<IScene>;	
		}
		
		public function set root(value:Sprite):void
		{
			cleanScene();
			_root = value;
		}
		
		public function get root():Sprite
		{
			return _root;
		}
		
		public function openScene(target:IScene, data:* = undefined):void
		{
			if (!target) throw Error("图层为NULL");
			sceneList.push(target);
			enterScene(target, data);
		}
		
		public function replaceScene(target:IScene, data:Object = null):void
		{
			if (!target) throw Error("图层为NULL");
			closeCurrent();
			sceneList.push(target);
			enterScene(target, data);
		}
		
		public function closeScene(target:IScene):void
		{
			for (var i:int = sceneList.length - 1; i >= 0; i--) {
				const scene:IScene = sceneList[i];
				if (scene == target) 
				{
					sceneList.splice(i, 1);
					exitScene(scene);
					break;
				}
			}
		}
		
		public function closeByName(name:String):void
		{
			for (var i:int = sceneList.length - 1; i >= 0; i--) {
				const scene:IScene = sceneList[i];
				if (scene.getSceneName() == name) 
				{
					sceneList.splice(i, 1);
					exitScene(scene);
				}
			}
		}
		
		public function closeCurrent():Boolean
		{
			if (sceneList.length) 
			{
				exitScene(sceneList.pop());
				return true;
			}
			return false;
		}
		
		public function cleanScene():void
		{
			if (sceneList.length) {
				const list:Vector.<IScene> = sceneList;
				sceneList = new Vector.<IScene>;
				for each(var scene:IScene in list) {
					exitScene(scene);
				}
			}
		}
		
		public function getCurrentScene():IScene
		{
			if (sceneList.length > 0) return sceneList[sceneList.length - 1];
			return null;
		}
		
		public function isOpen(target:IScene):Boolean
		{
			return sceneList.indexOf(target) != -1;
		}
		
		public function isOpenByName(name:String):Boolean
		{
			for each(var scene:IScene in sceneList) {
				if (scene.getSceneName() == name) return true;
			}
			return false;
		}
		
		//个数
		public function getLength():int
		{
			return sceneList.length;
		}
		
		//private---------
		private function enterScene(scene:IScene, data:*):void
		{
			trace("进入场景:", scene.getSceneName());
			scene.onEnter(data);
		}
		
		private function exitScene(scene:IScene):void
		{
			trace("退出场景:", scene.getSceneName());
			scene.onExit();
		}
		
		//end
	}

}