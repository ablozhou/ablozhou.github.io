---
layout: post
title:  "mac下更新delve调试go语言"
author: "周海汉"
date:   2018-08-21 19:28:26 +0800
categories: tech
tags:
    - delve
    - 调试
    - go
    - goland

---

# 概述
delve 是golang调试程序。但如果版本不配套，
mac下goland 调试，step over会不起作用，直接变成执行完毕或者到下一个断点。
需要更新调试器delve解决。

# go get安装
mac下安装delve，官方教程是两步。

```
$ xcode-select --install
xcode-select: error: command line tools are already installed, use "Software Update" to install updates

$ go get -u github.com/derekparker/delve/cmd/dlv
```
但go get 一直不返回。

# homebrew 安装

```
zhouhh@/Users/zhouhh $ brew install go-delve/delve/delve
Updating Homebrew...
==> Installing delve from go-delve/delve
==> Downloading https://github.com/derekparker/delve/archive/v1.0.0.tar.gz
Already downloaded: /Users/zhouhh/Library/Caches/Homebrew/delve-1.0.0.tar.gz
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
==> Generating dlv-cert
==> openssl req -new -newkey rsa:2048 -x509 -days 3650 -nodes -config dlv-cert.cfg -extensions codesign_reqext -batch -out dlv-cert.cer -keyout dlv-cert.key
==> [SUDO] Installing dlv-cert as root
==> sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain dlv-cert.cer
Last 15 lines from /Users/zhouhh/Library/Logs/Homebrew/delve/02.sudo:
2018-08-09 17:07:38 +0800

sudo
security
add-trusted-cert
-d
-r
trustRoot
-k
/Library/Keychains/System.keychain
dlv-cert.cer


If reporting this issue please do so at (not Homebrew/brew or Homebrew/core):
https://github.com/go-delve/homebrew-delve/issues

These open issues may also help:
Upgrade to delve fails https://github.com/go-delve/homebrew-delve/issues/20
/usr/local/Homebrew/Library/Homebrew/exceptions.rb:426:in `block in dump': undefined method `check_for_bad_install_name_tool' for #<Homebrew::Diagnostic::Checks:0x007fc5df858bd8> (NoMethodError)
Did you mean?  check_for_tap_ruby_files_locations
	from /usr/local/Homebrew/Library/Homebrew/exceptions.rb:425:in `each'
	from /usr/local/Homebrew/Library/Homebrew/exceptions.rb:425:in `dump'
	from /usr/local/Homebrew/Library/Homebrew/brew.rb:138:in `rescue in <main>'
	from /usr/local/Homebrew/Library/Homebrew/brew.rb:30:in `<main>'
	
	
```
这是因为证书有问题。
可以到homebrew缓存下载的delve里处理一下。
```
zhouhh@/Users/zhouhh $ cd $HOME/Library/Caches/Homebrew
zhouhh@/Users/zhouhh/Library/Caches/Homebrew $ ls del*
delve-1.0.0.tar.gz

zhouhh@/Users/zhouhh/Library/Caches/Homebrew $ tar zxvf delve-1.0.0.tar.gz
zhouhh@/Users/zhouhh/Library/Caches/Homebrew $ sh delve-1.0.0/scripts/gencert.sh
Password:

```
再安装成功
```
zhouhh@/Users/zhouhh/Library/Caches/Homebrew $ CGO_ENABLED=1 brew install go-delve/delve/delve
==> Installing delve from go-delve/delve
==> Downloading https://github.com/derekparker/delve/archive/v1.0.0.tar.gz
Already downloaded: /Users/zhouhh/Library/Caches/Homebrew/delve-1.0.0.tar.gz
==> dlv-cert is already installed, no need to create it
==> make build BUILD_SHA=v1.0.0
==> Caveats
If you get "could not launch process: could not fork/exec", you need to try
in a new terminal.

When uninstalling, to remove the dlv-cert certificate, run this command:

    $ sudo security delete-certificate -t -c dlv-cert /Library/Keychains/System.keychain

Alternatively, you may want to delete from the Keychain (with the Imported private key).

==> Summary
🍺  /usr/local/Cellar/delve/1.0.0: 6 files, 10.6MB, built in 13 seconds

```
 安装成功
 

# 修改ide环境
 
 安装完最新的 delve 后，如 brew install delve, 然后在IntelliJ或goland中点击
 ```
Help → Edit Custom Properties...
```
添加新行
```
dlv.path=/usr/local/bin/dlv

 ```
 保存重启，解决step over(F8) 直接运行完毕的bug。
