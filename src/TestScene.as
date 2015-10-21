package  
{
	import flash.text.TextField;
	import org.sdk.display.com.scroll.Cell;
	import org.sdk.display.com.scroll.TableView;
	import org.sdk.display.com.Image;
	import org.sdk.display.core.KindMap;
	import org.sdk.display.BaseScene;
	import org.sdk.effects.DisplayEffects;
	
	/**
	 * ...
	 * @author Mike email:542540443@qq.com
	 */
	public class TestScene extends BaseScene 
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
		}
		
		private function spaceHandler(index:int):int
		{
			return 30;
		}
		
		private function rollHandler(table:TableView,index:int):Cell
		{
			const cell:Cell = table.getQueue(index);
			var a:KindMap = new KindMap("btn_b_down");
			a.setSize(a.width, a.height);
			cell.addNodeDisplay(a);
			var text:TextField = new TextField;
			text.htmlText="<font color='#ffffff' size='18'>"+index+"</font>";
			text.mouseEnabled = false;
			cell.convertSprite.addChild(text);
			return cell;
		}
		
		private function called(index:int=-1):void
		{
			trace("xxx", index);
			var table:TableView = new TableView;
			table.setSize(100,400);
			table.resetting(200,spaceHandler,rollHandler);
			this.addNodeDisplay(table);
			table.setPosition(100,100);
		}
		
		//ends
	}

}