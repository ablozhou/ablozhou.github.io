---
author: abloz
comments: true
date: 2006-07-12 08:35:12+00:00
layout: post
link: http://abloz.com/index.php/2006/07/12/e4-bd-bf-e7-94-a8red5-e5-92-8cffmpeg-e6-90-ad-e5-bb-ba-e5-9c-a8-e7-ba-bfflash-e6-b5-81-e5-aa-92-e4-bd-93-e5-88-86-e4-ba-ab-e5-b9-b3-e5-8f-b0-e3-80-90-e8-bd-ac-e3-80-91/
slug: e4-bd-bf-e7-94-a8red5-e5-92-8cffmpeg-e6-90-ad-e5-bb-ba-e5-9c-a8-e7-ba-bfflash-e6-b5-81-e5-aa-92-e4-bd-93-e5-88-86-e4-ba-ab-e5-b9-b3-e5-8f-b0-e3-80-90-e8-bd-ac-e3-80-91
title: 使用Red5和FFMpeg搭建在线Flash流媒体分享平台【转】
wordpress_id: 687
categories:
- 转载
---




### [_使用Red5和FFMpeg搭建在线Flash流媒体分享平台_](http://www.example.net.cn/2006/06/red5ffmpegflash.html)




最近视频的东西比较火，前些天我也稍微了解了一下使用开源软件建在线Flash流媒体播放平台的解决方案，还是有一些收获。




[_Red5_](http://osflash.org/red5)是一款基于java的开源的Flash流媒体Server 软件，可以作为取代Macromedia提供的商业版本FMS。Red5使用RSTP作为流媒体传输协议，内置了一些示例，这些示例实现了在线录制， flash流媒体播放，在线聊天，视频会议等一些基本的功能。由于系统本身是开源的，在碰到问题的时候也比较容易解决，大不了直接改代码，在成本方面也可以省下一笔不小的开销，为未来的功能扩展也提供了充分的空间。




如果仅仅是实现在线录制，在线播放，那么Red5也就差不多够了，但可能我们有时候还需要用户上传自己拍摄的视频文件，而要把这些视频文件转成可播放的flv文件就需要视频编码软件了。[_FFMpeg_](http://ffmpeg.mplayerhq.hu/)提供了录制，播放，视频流处理的完整解决方案。它自身也带了一个基于HTTP的流媒体广播程序以及其它几个实用的程序，但我们的重点还是它的视频转换程序，似乎Google Video也是用的它的程序作为视频转换工具。




我用FFMpeg转了几个视频，效果还可以，在声音上碰到了一些问题，在不添加参数的情况下，有一部分视频的声音会有问题，有的视频无论怎么添加参数，都出不来声音，报错提示的是不支持所带的声音采样格式，只支持几种固定的格式，我看了一下代码，确实是这样子，但理论上应该是能够解决的。 FFMpeg自带的libavcodec是一套很牛的编码库，为了保证质量和性能，里面的很多codec都是从头开发的。




这两个加起来，实现一些简单的在线视频功能就差不多了。




PS:今天刚看到古永锵也开始做小视频分享网站：[_优酷_](http://www.yoqoo.com/index/)。
