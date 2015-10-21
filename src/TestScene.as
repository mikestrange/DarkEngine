package  
{
	import flash.text.TextField;
	import org.sdk.display.com.interfaces.ITableViewDelegate;
	import org.sdk.display.com.scroll.Cell;
	import org.sdk.display.com.scroll.TableView;
	import org.sdk.display.com.Image;
	import org.sdk.display.core.KindMap;
	import org.sdk.display.BaseScene;
	import org.sdk.effects.DisplayEffects;
	import org.sdk.key.IKeyDelegate;
	import org.sdk.key.KeyEvent;
	import org.sdk.key.KeyManager;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class TestScene extends BaseScene implements IKeyDelegate, ITableViewDelegate
	{
		
		override public function onEnter(data:* = undefined):void 
		{
			super.onEnter(data);
			var a:KindMap = new KindMap("btn_b_down");
			a.setSize(a.width, a.height);
			this.addChild(a.convertDisplayObject);
			//
			var g:Image = new Image("http://passport.lagou.com/lp/images/position/souhu.png");
			this.addChild(g);
			var g1:Image = new Image("http://passport.lagou.com/lp/images/position/souhu.png");
			g1.x = 100;
			this.addChild(g1);
			var g2:Image = new Image("http://passport.lagou.com/lp/images/position/souhu.png");
			g2.x = 200;
			this.addChild(g2);
			DisplayEffects.pervasion(a);
			//
			scheduler.applyMethod(called, 100);
			//
			KeyManager.setEnabled(true);
			KeyManager.addKeyListener(this);
		}
		
		public function rowHandler():int
		{
			return 30;
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
			table.setPosition(100,100);
			table.delegate = this;
			table.reallocated();
			this.addNodeDisplay(table);
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