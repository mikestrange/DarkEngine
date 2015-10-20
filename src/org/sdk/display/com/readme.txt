//test
	

//拖动条的使用
var scroll:ScrollSprite = new ScrollSprite;
scroll.setLimit(100, 300);
scroll.alpha = .3;
//返回行
scroll.sizeHandler = function():int 
{ 
	return 30;
}
//每一个位置的间距
scroll.spaceHandler = function(index:int):Number
{ 
	return 30; 
}
//缓冲函数
scroll.rollHandler = rollHandler;
scroll.updateScroll();
scroll.setAlign("center", 0, -100);
this.addDisplay(scroll);
		
function rollHandler(scroll:ScrollSprite, index:int):IListItem
{
	var cell:IListItem = scroll.getQueue(index);
	var ray:RayDisplayer = new RayDisplayer();
	ray.setLiberty("btn_b_keep", null, RayDisplayer.BIT_TAG);
	cell.addDisplay(ray);
	TextEditor.quick(index.toString(), cell, 20, 0xffff00).setAlign("center");
	return cell;
}


//选择器的使用
var chool:Chooser = new Chooser(2);
chool.setList(Vector.<ITouch>([new TouchTest, new TouchTest, new TouchTest, new TouchTest]));
chool.select(1);
chool.select(0);
chool.select(1);
chool.select(3);
chool.select(1);
//chool.restore();