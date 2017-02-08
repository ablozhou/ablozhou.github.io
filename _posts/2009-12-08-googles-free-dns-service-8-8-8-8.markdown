---
author: abloz
comments: true
date: 2009-12-08 05:58:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/08/googles-free-dns-service-8-8-8-8/
slug: googles-free-dns-service-8-8-8-8
title: 谷歌的免费DNS服务8.8.8.8
wordpress_id: 977
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

从谷奥得到[消息](http://www.google.org.cn/posts/google-release-free-public-dns.html) ，google推出了两个非常好记的DNS服务器。那就是

 

8.8.8.8

8.8.4.4

 

经本人测试可用。有人说4.4.4.4和4.3.2.1也是，经过我测试，这两个IP可以ping通，但并不能做DNS 解析。

 

下面是测试经过：

  1. zhouhh@zhhofs:~$ ping 8.8.8.8
  2. PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
  3. 64 bytes from 8.8.8.8: icmp_seq=1 ttl=240 time=200 ms
  4. 64 bytes from 8.8.8.8: icmp_seq=2 ttl=240 time=84.7 ms
  5. ^C
  6. --- 8.8.8.8 ping statistics ---
  7. 2 packets transmitted, 2 received, 0% packet loss, time 1000ms
  8. rtt min/avg/max/mdev = 84.771/142.731/200.691/57.960 ms
  9. zhouhh@zhhofs:~$ ping 8.8.4.4
  10. PING 8.8.4.4 (8.8.4.4) 56(84) bytes of data.
  11. 64 bytes from 8.8.4.4: icmp_seq=1 ttl=240 time=111 ms
  12. 64 bytes from 8.8.4.4: icmp_seq=2 ttl=240 time=113 ms
  13. ^C
  14. --- 8.8.4.4 ping statistics ---
  15. 2 packets transmitted, 2 received, 0% packet loss, time 1001ms
  16. rtt min/avg/max/mdev = 111.370/112.358/113.346/0.988 ms
  17. zhouhh@zhhofs:~$ ping 4.3.2.1
  18. PING 4.3.2.1 (4.3.2.1) 56(84) bytes of data.
  19. 64 bytes from 4.3.2.1: icmp_seq=1 ttl=240 time=107 ms
  20. 64 bytes from 4.3.2.1: icmp_seq=2 ttl=240 time=102 ms
  21. ^C
  22. --- 4.3.2.1 ping statistics ---
  23. 2 packets transmitted, 2 received, 0% packet loss, time 1001ms
  24. rtt min/avg/max/mdev = 102.059/104.628/107.198/2.589 ms
  25. zhouhh@zhhofs:~$ nslookup 8.8.8.8
  26. Server: 8.8.8.8
  27. Address: 8.8.8.8#53
  28. Non-authoritative answer:
  29. 8.8.8.8.in-addr.arpa name = google-public-dns-a.google.com.
  30. Authoritative answers can be found from:
  31. zhouhh@zhhofs:~$ nslookup 8.8.4.4
  32. Server: 8.8.8.8
  33. Address: 8.8.8.8#53
  34. 
Non-authoritative answer:
  35. 4.4.8.8.in-addr.arpa name = google-public-dns-b.google.com.
  36. Authoritative answers can be found from:
  37. zhouhh@zhhofs:~$ nslookup 4.4.4.4
  38. Server: 8.8.8.8
  39. Address: 8.8.8.8#53
  40. ** server can't find 4.4.4.4.in-addr.arpa.: NXDOMAIN
  41. zhouhh@zhhofs:~$ nslookup 4.3.2.1
  42. Server: 8.8.8.8
  43. Address: 8.8.8.8#53
  44. ** server can't find 1.2.3.4.in-addr.arpa: SERVFAIL
  45. zhouhh@zhhofs:~$ nslookup 1.2.3.4
  46. Server: 8.8.8.8
  47. Address: 8.8.8.8#53
  48. ** server can't find 4.3.2.1.in-addr.arpa.: NXDOMAIN
  49. zhouhh@zhhofs:~$ nslookup
  50. > server 8.8.8.8
  51. Default server: 8.8.8.8
  52. Address: 8.8.8.8#53
  53. > set type=a
  54. > google.com
  55. Server: 8.8.8.8
  56. Address: 8.8.8.8#53
  57. Non-authoritative answer:
  58. Name: google.com
  59. Address: 74.125.53.100
  60. Name: google.com
  61. Address: 74.125.67.100
  62. Name: google.com
  63. Address: 74.125.45.100
  64. > sohu.com
  65. Server: 8.8.8.8
  66. Address: 8.8.8.8#53
  67. Non-authoritative answer:
  68. Name: sohu.com
  69. Address: 61.135.181.176
  70. Name: sohu.com
  71. Address: 61.135.181.175
  72. > server 4.4.4.4
  73. Default server: 4.4.4.4
  74. Address: 4.4.4.4#53
  75. > set type a
  76. *** Invalid option: type
  77. > set type = a
  78. *** Invalid option: type
  79. > set type=a
  80. > google.com
  81. ^C
  82. 解析失败，超时
  83.   84. zhouhh@zhh64:~$ nslookup
  85. > server 4.3.2.1
  86. Default server: 4.3.2.1
  87. Address: 4.3.2.1#53
  88. > sohu.com
  89. Server: 4.3.2.1
  90. Address: 4.3.2.1#53
  91.   92. Non-authoritative answer:
  93. Name: sohu.com
  94. Address: 61.135.181.176
  95. Name: sohu.com
  96. Address: 61.135.181.175
  97. &
gt; set type a
  98. *** Invalid option: type
  99. > set type = a
  100. *** Invalid option: type
  101. > set type=a
  102. > sohu.com
  103. Server: 4.3.2.1
  104. Address: 4.3.2.1#53
  105.   106. Non-authoritative answer:
  107. Name: sohu.com
  108. Address: 61.135.181.175
  109. Name: sohu.com
  110. Address: 61.135.181.176
  111. > server 4.4.4.4
  112. Default server: 4.4.4.4
  113. Address: 4.4.4.4#53
  114. > set type=a
  115. > sohu.com
  116. ^C
  117. 4.4.4.4不通，4.3.2.1是通的。

zhouhh@zhhofs:~$ ping 8.8.8.8 PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data. 64 bytes from 8.8.8.8: icmp_seq=1 ttl=240 time=200 ms 64 bytes from 8.8.8.8: icmp_seq=2 ttl=240 time=84.7 ms ^C --- 8.8.8.8 ping statistics --- 2 packets transmitted, 2 received, 0% packet loss, time 1000ms rtt min/avg/max/mdev = 84.771/142.731/200.691/57.960 ms zhouhh@zhhofs:~$ ping 8.8.4.4 PING 8.8.4.4 (8.8.4.4) 56(84) bytes of data. 64 bytes from 8.8.4.4: icmp_seq=1 ttl=240 time=111 ms 64 bytes from 8.8.4.4: icmp_seq=2 ttl=240 time=113 ms ^C --- 8.8.4.4 ping statistics --- 2 packets transmitted, 2 received, 0% packet loss, time 1001ms rtt min/avg/max/mdev = 111.370/112.358/113.346/0.988 ms zhouhh@zhhofs:~$ ping 4.3.2.1 PING 4.3.2.1 (4.3.2.1) 56(84) bytes of data. 64 bytes from 4.3.2.1: icmp_seq=1 ttl=240 time=107 ms 64 bytes from 4.3.2.1: icmp_seq=2 ttl=240 time=102 ms ^C --- 4.3.2.1 ping statistics --- 2 packets transmitted, 2 received, 0% packet loss, time 1001ms rtt min/avg/max/mdev = 102.059/104.628/107.198/2.589 ms zhouhh@zhhofs:~$ nslookup 8.8.8.8 Server:		8.8.8.8 Address:	8.8.8.8#53 Non-authoritative answer: 8.8.8.8.in-addr.arpa	name = google-public-dns-a.google.com. Authoritative answers can be found from: zhouhh@zhhofs:~$ nslookup 8.8.4.4 Server:		8.8.8.8 Address:	8.8.8.8#53 Non-authoritative answer: 4.4.8.8.in-addr.arpa	name = google-public-dns-b.google.com. Authoritative answers can be found from: zhouhh@zhhofs:~$ nslookup 4.4.4.4 Server:		8.8.8.8 Address:	8.8.8.8#53 ** server can't find 4.4.4.4.in-addr.arpa.: NXDOMAIN zhouhh@zhhofs:~$ nslookup 4.3.2.1 Server:		8.8.8.8 Address:	8.8.8.8#53 ** server can't find 1.2.3.4.in-addr.arpa: SERVFAIL zhouhh@zhhofs:~$ nslookup 1.2.3.4 Server:		8.8.8.8 Address:	8.8.8.8#53 ** server can't find 4.3.2.1.in-addr.arpa.: NXDOMAIN zhouhh@zhhofs:~$ nslookup > server 8.8.8.8 Default server: 8.8.8.8 Address: 8.8.8.8#53 > set type=a > google.com Server:		8.8.8.8 Address:	8.8.8.8#53 Non-authoritative answer: Name:	google.com Address: 74.125.53.100 Name:	google.com Address: 74.125.67.100 Name:	google.com Address: 74.125.45.100 > sohu.com Server:		8.8.8.8 Address:	8.8.8.8#53 Non-authoritative answer: Name:	sohu.com Address: 61.135.181.176 Name:	sohu.com Address: 61.135.181.175 > server 4.4.4.4 Default server: 4.4.4.4 Address: 4.4.4.4#53 > set type a *** Invalid option: type > set type = a *** Invalid option: type > set type=a > google.com ^C 解析失败，超时  zhouhh@zhh64:~$ nslookup > server 4.3.2.1 Default server: 4.3.2.1 Address: 4.3.2.1#53 > sohu.com Server:		4.3.2.1 Address:	4.3.2.1#53  Non-authoritative answer: Name:	sohu.com Address: 61.135.181.176 Name:	sohu.com Address: 61.135.181.175 > set type a *** Invalid option: type > set type = a *** Invalid option: type > set type=a > sohu.com Server:		4.3.2.1 Address:	4.3.2.1#53  Non-authoritative answer: Name:	sohu.com Address: 61.135.181.175 Name:	sohu.com Address: 61.135.181.176 > server 4.4.4.4 Default server: 4.4.4.4 Address: 4.4.4.4#53 > set type=a > sohu.com ^C 4.4.4.4不通，4.3.2.1是通的。  

说明8.8.8.8，8.8.4.4可用。

后经补充测试， 4.3.2.1可用。

 

8.8.8.8、8.8.4.4和4.3.2.1不用担心域名绑架，但8.8.8.8、8.8.4.4和4.3.2.1有可能遭GFW封杀。

 

ps：后来一晚上给一个女生解决网络问题，配IP地址，在DNS 配了8.8.8.8，结果她问，“DNS 这个随便配一个就行了，是吧？” 8.8.8.8实在太吉祥太吉利太好记了，搞得大家都不相信。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=fb1b0eb1-fdb8-8167-84c2-5be06303eff5)
