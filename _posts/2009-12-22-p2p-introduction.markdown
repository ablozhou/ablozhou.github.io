---
author: abloz
comments: true
date: 2009-12-22 06:25:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/22/p2p-introduction/
slug: p2p-introduction
title: P2P介绍
wordpress_id: 993
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

  

在此介绍一下p2p相关技术。

 

1. DHT 覆盖网

DHT 是分布式hash网络的简写。DHT有好多实现协议和协议实现，如

  * [CAN](http://en.wikipedia.org/wiki/Content_Addressable_Network)  (Content Addressable Network)
  * [Chord](http://en.wikipedia.org/wiki/Chord_%28DHT%29)  
  * [Kademlia](http://en.wikipedia.org/wiki/Kademlia)  
  * [Pastry](http://en.wikipedia.org/wiki/Pastry_%28DHT%29)  
  * [P-Grid](http://en.wikipedia.org/wiki/P-Grid)  
  * [Tapestry](http://en.wikipedia.org/wiki/Tapestry_%28DHT%29)  

用户在DHT  中扮演一个节点，各个节点组成一张DHT网络。节点ID用一个128位或160位长的hash值标示。节点有一张路由表，根据算法找到他的相邻或n跳的节 点。在文件共享时（每种协议和实现不一定一样），可以将文件内容用一种算法（如HA1  hash）得到一个ID，再将内容放到该ID应该放的节点（通过算法，经过n跳找到该节点或相关若干节点）。对文件名，早期是完全匹配，将完整文件名进行 hash，得到一个id，该id就可以索引到存放索引的节点。存放索引的节点又能找到内容存放节点。后期支持关键字搜索，将文件名分散成若干关键字，都 hash，存放到相应的索引节点。

 

2. DHT网络的应用实现(from wikipedia)

  * [BitTorrent](http://en.wikipedia.org/wiki/BitTorrent_%28protocol%29)  : File distribution. BitTorrent optionally uses a DHT as a distributed tracker to provide rendezvous between clients sharing a particular file (see [BitTorrent client](http://en.wikipedia.org/wiki/BitTorrent_client)  )
  * [Codeen](http://en.wikipedia.org/wiki/Codeen)  : Web caching
  * [Coral Content Distribution Network](http://en.wikipedia.org/wiki/Coral_Content_Distribution_Network)  
  * [Freenet](http://en.wikipedia.org/wiki/Freenet)  : A censorship-resistant anonymous network.
  * [Deluge](http://en.wikipedia.org/wiki/Deluge_%28software%29)  : BitTorrent client available on many operating systems (Linux, Mac OS X, Unix, MS Windows).
  * [Dijjer](http://en.wikipedia.org/wiki/Dijjer)  : Freenet-like distribution network
  * [eMule](http://en.wikipedia.org/wiki/EMule)  : File sharing
  * [FAROO](http://en.wikipedia.org/wiki/FAROO)  : Peer-to-peer web search engine
  * [GNUnet](http://en.wikipedia.org/wiki/GNUnet)  : Freenet-like distribution network including a DHT implementation [[1]](http://gnunet.org/protocol_p2p_dht.php3?xlang=English)  
  * [JXTA](http://en.wikipedia.org/wiki/JXTA)  : Opensource P2P platform
  * [KTorrent](http://en.wikipedia.org/wiki/KTorrent)  : KDE BitTorrent client
  * [LimeWire](http://en.wikipedia.org/wiki/LimeWire)  : File sharing; includes the [Mojito DHT](http://wiki.limewire.org/index.php?title=Mojito)  
  * [NEOnet](http://en.wikipedia.org/wiki/NEOnet)  : File sharing
  * [OneSwarm](http://en.wikipedia.org/wiki/OneSwarm)  : File sharing. The Kademlia DHT is used to store encrypted IP addresses.
  * [Overnet](http://en.wikipedia.org/wiki/Overnet)  : File sharing
  * [Qbittorrent](http://en.wikipedia.org/wiki/Qbittorrent)  : BitTorrent Client
  * [The Circle](http://en.wikipedia.org/wiki/The_Circle_%28file_system%29)  : File sharing and chat
  * [Transmission](http://en.wikipedia.org/wiki/Transmission_%28BitTorrent_client%29)  : BitTorrent Client
  * [µTorrent](http://en.wikipedia.org/wiki/%CE%9CTorrent)  : BitTorrent client
  * [Vuze](http://en.wikipedia.org/wiki/Vuze)  : First BitTorrent client to implement DHT, at that time known as Azureus.
  * [Warez P2P](http://en.wikipedia.org/wiki/Warez_P2P)  : File sharing
  * [YaCy](http://en.wikipedia.org/wiki/YaCy)  : distributed [search engine](http://en.wikipedia.org/wiki/Web_search_engine)  
  * [maidsafe](http://en.wikipedia.org/w/index.php?title=Maidsafe&action=edit&redlink=1)  : c++ implementation of Kademlia (BSD license), with NAT traversal and crypto libraries.[maidsafe-dht](http://code.google.com/p/maidsafe-dht/)  
 

3.最新的Kademlia

第一代p2p，Napster，就是传统的bt，需要一个中心服务器来分享索引信息。因此很容易遭到起诉，Napster就是诉讼缠身。  第二代p2p,Gnutella 采用广播查询(flood  locate)的方式，引起很多性能问题。第三代的DHT，所有信息都分布于整个网络，采用hash ID来定位。

kademlia则类似DHT，不过基于两个节点的距离算法。索引信息放在上网时间长的节点。

参考：http://en.wikipedia.org/wiki/Kademlia#Locating_resources

 

4.展望

基于分布式哈希表的P2P，相当于利用算法，在实体网络上新建了一层逻辑的覆盖网络或虚拟网络。由于每个用户同时也是服务提供者，不存在一个集中的节点。而其上的业务，则可以开展新闻，论坛，博客，文件共享，聊天室，发消息等各种应用。

 

参考：http://en.wikipedia.org/wiki/Distributed_hash_table

  
  


![](http://img.zemanta.com/pixy.gif?x-id=ff65eb8a-8567-8c2e-8e02-27373c91797e)
