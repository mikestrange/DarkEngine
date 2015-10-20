package 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import org.sdk.debug.Log;
	import org.sdk.display.com.button.BoxButton;
	import org.sdk.display.core.BaseSprite;
	import org.sdk.display.core.Image;
	import org.sdk.display.core.Image;
	import org.sdk.display.core.MapSheet;
	import org.sdk.engine.MotivePower;
	import org.sdk.AppWork;
	import org.sdk.interfaces.IRender;
	import org.sdk.key.KeyEvent;
	import org.sdk.key.KeyManager;
	import org.sdk.load.DownLoader;
	import org.sdk.load.LoadEvent;
	import org.sdk.load.QueueManager;
	import org.sdk.utils.NumHover;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class Main extends BaseSprite 
	{
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//只要设置匹配方案就可以了，不必纠结于code
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			AppWork.setApp(stage);
			AppWork.getSceneManager().root = this;
			DownLoader.create("common.swf", complete);
		}
		
		private function complete(event:LoadEvent):void
		{
			var target:Loader = event.data as Loader;
			var loader:Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.loadBytes(target.contentLoaderInfo.bytes, new LoaderContext(false, ApplicationDomain.currentDomain));
		}
		
		private function onComplete(event:Event):void
		{
			AppWork.getSceneManager().replaceScene(new TestScene);
			//
			AppWork.getSceneManager().replaceScene(new TestScene);
			//
			AppWork.getSceneManager().replaceScene(new TestScene);
		}
		//end
	}
	
}