package org.sdk.classes.common {
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class Sleep 
	{
		private static var _song:Sound;
		
		//true 允许休眠模式  false不允许休眠
		public static function get canSleep():Boolean
		{
			return null != _song;
		}
		
		//是否允许休眠模式  true允许休眠 ，false不允许进入休眠
		public static function set canSleep(value:Boolean):void
		{
			if (!value) {
				if (null == _song) {
					_song = new Sound;
					_song.load(new URLRequest(""));
					_song.play();
					_song.close();
					_song.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleDataHandler);
					_song.play();
				}
			}else {
				stopPlay();
			}
		}
		
		private static function onSampleDataHandler(event:SampleDataEvent):void
		{
			event.data.position = event.data.length = 4096 * 4;
		}
		
		private static function stopPlay():void
		{
			if (_song) {
				_song.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleDataHandler);
				_song = null;
			}
		}
		//ends
	}

}