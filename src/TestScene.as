package  
{
	import com.greensock.TweenLite;
	
	import flash.text.TextField;
	
	import org.sdk.AppWork;
	import org.sdk.display.DelegateDefined;
	import org.sdk.display.KindScene;
	import org.sdk.display.com.Image;
	import org.sdk.display.com.KindButton;
	import org.sdk.display.com.TableView;
	import org.sdk.display.com.interfaces.ITableViewDelegate;
	import org.sdk.display.com.item.Cell;
	import org.sdk.display.com.selector.SelectedController;
	import org.sdk.display.core.KindMap;
	import org.sdk.effects.DisplayEffects;
	import org.sdk.interfaces.INodeDisplay;
	import org.sdk.key.IKeyDelegate;
	import org.sdk.key.KeyEvent;
	import org.sdk.key.KeyManager;
	import org.sdk.net.https.HttpRequest;
	import org.sdk.net.https.NetHttps;
	import org.sdk.utils.display.TransformUtil;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class TestScene extends KindScene implements IKeyDelegate, ITableViewDelegate
	{
		override public function onEnter(data:* = undefined):void 
		{
			super.onEnter(data);
			var mit:KindMap = new KindMap("btn_b_down");
			mit.setSize(mit.width, mit.height);
			this.addNodeDisplay(mit);
			mit.setPosition(100,20);
			//
			const g2:Image = new Image("http://passport.lagou.com/lp/images/position/souhu.png");
			g2.setTag(2);
			g2.delegate = this;
			g2.setPosition(100,100);
			this.addNodeDisplay(g2);
			//
			var btn:KindButton = new KindButton();
			btn.delegate = this;
			this.addNodeDisplay(btn);
			//
			scheduler.applyMethod(called, 100);
			//
			KeyManager.setEnabled(true);
			KeyManager.addKeyListener(this);
			//
			var net:NetHttps = new NetHttps;
			net.sendRequest(new HttpRequest("http://127.0.0.1/"));
			net.sendRequest(new HttpRequest("http://127.0.0.1/"));
			net.sendRequest(new HttpRequest("http://127.0.0.1/"));
			net.sendRequest(new HttpRequest("http://127.0.0.2/"));
		}
		
		public function rowHandler():int
		{
			return 300;
		}
		
		public function spaceHandler(index:int):int
		{
			return 30;
		}
		
		public function rollHandler(table:TableView, floor:int):Cell
		{
			const cell:Cell = table.getQueue(floor);
			var a:KindMap = new KindMap("btn_b_down");
			a.setSize(a.width, a.height);
			cell.addNodeDisplay(a);
			var text:TextField = new TextField;
			text.htmlText="<font color='#ffffff' size='18'>"+floor+"</font>";
			text.mouseEnabled = false;
			cell.addChild(text);
			return cell;
		}
		
		private function called():void
		{
			var table:TableView = new TableView(100, 300);
			table.setTag(10);
			table.setPosition(100,100);
			table.delegate = this;
			table.reallocated();
			this.addNodeDisplay(table,0);
			//
		}
		
		override public function applyHandler(notice:String, target:Object=null):void
		{
			if(notice == DelegateDefined.BUTTON_CLICK)
			{
				trace("click");
			}
			if(notice == DelegateDefined.IMAGE_COMPLETE)
			{
				trace("click");
				var g:INodeDisplay = this.getChildByTag(2);
				this.setChildIndex(g.convertDisplayObject,this.numChildren-1);
			}
		}
		
		public function onKeyDownHandler(code:uint):void
		{
			trace(code)
		}
		
		public function onKeyUpHandler(event:KeyEvent):void
		{
			trace("up", event.code);
		}
		
		//ends
	}

}