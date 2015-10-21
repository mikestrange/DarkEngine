*TableView用法
var table:TableView = new TableView(100, 300);
table.delegate = this;
table.reallocated();  //应用委托，并且刷新显示
this.addNodeDisplay(table);