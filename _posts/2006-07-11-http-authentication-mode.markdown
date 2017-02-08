---
author: abloz
comments: true
date: 2006-07-11 05:34:48+00:00
layout: post
link: http://abloz.com/index.php/2006/07/11/http-authentication-mode/
slug: http-authentication-mode
title: http 的认证模式
wordpress_id: 158
categories:
- 技术
tags:
- http
- sip
- 认证
---


周海汉 2006.7.11
ablozhou@gmail.com

SIP类似Http协议。其认证模式也一样。Http协议（RFC 2616 ）规定可以采用Base模式和摘要模式（Digest schema）。RFC 2617 专门对两种认证模式做了规定。RFC 1321 是MD5标准。Digest对现代密码破解来说并不强壮，但比基本模式还是好很多。MD5已经被山东大学教授找到方法可以仿冒（我的理解），但现在还在广泛使用。

1.最简单的攻击方式

如果网站要求认证，客户端发送明文的用户名密码，那网络上的窃听者可以轻而易举的获得用户名密码，起不到安全作用。我上学时曾在科大实验室局域网内窃听别人的科大BBS的密码，发现BBS的用户名密码居然是明文传输的。那种做贼的心虚和做贼的兴奋让人激动莫名。偷人钱财会受到道德谴责，偷人密码只会暗自得意忘形。比“窃书不算偷”还没有罪恶感。因此你的用户名和密码明文传输的话，无异将一块肥肉放在嘴馋的人面前。现在很多ASP网站的认证都将用户名和密码用MD5加密。MD5是将任意长度的字符串和128位的随机数字运算后生成一个16byte的加密字符串。因此窃听者抓住的是一团乱码。但是，这有一个问题：如果窃听者就用这团乱码去认证，还是可以认证通过。因为服务器将用户名密码MD5加密后得到的字符串就是那一团乱码，自然不能区别谁是合法用户。这叫重放攻击（replay attack）。这和HTTP的基本认证模式差不多。为了安全，不要让别人不劳而获，自然要做基本的防范。下面是Http协议规定的两种认证模式。

2.基本认证模式

客户向服务器发送请求，服务器返回401（未授权），要求认证。401消息的头里面带了挑战信息。realm用以区分要不同认证的部分。客户端收到401后，将用户名密码和挑战信息用BASE64加密形成证书，发送回服务器认证。语法如下：

       challenge   = "Basic" realm
      credentials = "Basic" basic-credentials

示例：

   认证头： WWW-Authenticate: Basic realm="zhouhh@mydomain.com"
   证书：Authorization: Basic QsdfgWGHffuIcaNlc2FtZQ==


3.摘要访问认证

为了防止重放攻击，采用摘要访问认证。在客户发送请求后，收到一个401（未授权）消息，包含一个 Challenge。消息里面有一个唯一的字符串：nonce，每次请求都不一样。客户将用户名密码和401消息返回的挑战一起加密后传给服务器。这样即使有窃听，他也无法通过每次认证，不能重放攻击。Http并不是一个安全的协议。其内容都是明文传输。因此不要指望Http有多安全。

语法：

      challenge        =  "Digest" digest-challenge

      digest-challenge  = 1#( realm | [ domain ] | nonce |
                          [ opaque ] |[ stale ] | [ algorithm ] |
                          [ qop-options ] | [auth-param] )


      domain            = "domain" "=" <"> URI ( 1*SP URI ) <">
      URI               = absoluteURI | abs_path
      nonce             = "nonce" "=" nonce-value
      nonce-value       = quoted-string
      opaque            = "opaque" "=" quoted-string
      stale             = "stale" "=" ( "true" | "false" )
      algorithm         = "algorithm" "=" ( "MD5" | "MD5-sess" |
                           token )
      qop-options       = "qop" "=" <"> 1#qop-value <">
      qop-value         = "auth" | "auth-int" | token


realm：让客户知道使用哪个用户名和密码的字符串。不同的领域可能密码不一样。至少告诉用户是什么主机做认证，他可能会提示用哪个用户名登录，类似一个Email。
domain：一个URI列表，指示要保护的域。可能是一个列表。提示用户这些 URI采用一样的认证。如果为空或忽略则为整个服务器。
nonce：随机字符串，每次401都不一样。跟算法有关。算法类似Base64加密：time-stamp H(time-stamp ":" ETag ":" private-key) 。time-stamp为服务器时钟，ETag为请求的Etag头。private-key为服务器知道的一个值。
opaque：服务器产生的由客户下去请求时原样返回。最好是Base64串或十六进制字符串。
auth-param：为扩展用的，现阶段忽略。
其他域请参考 RFC2617。

授权头语法：


       credentials      = "Digest" digest-response
       digest-response  = 1#( username | realm | nonce | digest-uri
                       | response | [ algorithm ] | [cnonce] |
                       [opaque] | [message-qop] |
                           [nonce-count]  | [auth-param] )

       username         = "username" "=" username-value
       username-value   = quoted-string
       digest-uri       = "uri" "=" digest-uri-value
       digest-uri-value = request-uri   ; As specified by HTTP/1.1
       message-qop      = "qop" "=" qop-value
       cnonce           = "cnonce" "=" cnonce-value
       cnonce-value     = nonce-value
       nonce-count      = "nc" "=" nc-value
       nc-value         = 8LHEX
       response         = "response" "=" request-digest
       request-digest = <"> 32LHEX <">
       LHEX             =  "0" | "1" | "2" | "3" |
                           "4" | "5" | "6" | "7" |
                           "8" | "9" | "a" | "b" |
                           "c" | "d" | "e" | "f"


response：加密后的密码
digest-uri：拷贝Request-Line，用于 Proxy
cnonce：如果qop设置，才设置，用于双向认证，防止攻击。
nonce-count:如果服务器看到同样的计数，就是一次重放。

示例：

401响应：        HTTP/1.1 401 Unauthorized
         WWW-Authenticate: Digest
                 realm="testrealm@host.com",
                 qop="auth,auth-int",
                 nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093",
                 opaque="5ccc069c403ebaf9f0171e9517f40e41"
再次请求：
         Authorization: Digest username="Mufasa",
                 realm="testrealm@host.com",
                 nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093",
                 uri="/dir/index.html",
                 qop=auth,
                 nc=00000001,
                 cnonce="0a4f113b",
                 response="6629fae49393a05397450978507c4ef1",
                 opaque="5ccc069c403ebaf9f0171e9517f40e41"
4.比较基本认证和摘要访问认证都是很脆弱的。基本认证可以让窃听者直接获得用户名和密码，而摘要访问认证窃听者只能获得一次请求的文档。
