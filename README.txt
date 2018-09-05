/*
*xm_speech for linux 1.0
*
*by fanfan
*/

1.doc目录下存放开发文档等；

2.lib目录下存放SDK需要调用的动态库。

3.include目录下存放SDK需要的头文件。


这是一个连续语音识别的project
框架：
前端以python speechrecognition包开发，自动监听和采集音频；
核心识别部分以讯飞离线语音识别sdk开发，将音频数据转化为文本；
中间以ROS server作为两部分通信和收发数据的通道。

注意：讯飞sdk 试用35天，msc 文件夹应放到当前工作路径，否则会报错
