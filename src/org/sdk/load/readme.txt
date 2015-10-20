##更容易扩展的DownLoader，能够完成所有下载方式


1，CheckLoader作为一个资源下载的管理中心，为静态方法
2，Downloader是一个下载器，放入队列中去下载
3，LoadEvent作为一个响应器
4，LoadRequest下载需要的数据，通过真正的下载器去下载
5，LoadSetup设置下载的响应装置