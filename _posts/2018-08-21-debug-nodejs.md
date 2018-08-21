---
layout: post
title:  "如何调试nodejs代码"
author: "周海汉"
date:   2018-08-21 19:28:26 +0800
categories: tech
tags:
    - javascript
    - ES6
    - node-inspect
    - nodejs
    - debug

---
# 概述

nodejs由于没有界面，调试起来比较困难。本文介绍了一些用调试nodejs的方法和工具。
最方便的方式是用chrome调试nodejs。

```
zhouhh@/Users/zhouhh/git/uringsig $ node --inspect-brk index.js
Debugger listening on ws://127.0.0.1:9229/3a1eaae7-2ede-4b96-b803-93675a055b59
For help see https://nodejs.org/en/docs/inspector

```
3a1eaae7-2ede-4b96-b803-93675a055b59 是进程的唯一UUID。
--inspect 让nodejs支持[inspector协议](https://chromedevtools.github.io/debugger-protocol-viewer/v8/)，监听websocket端口。缺省127.0.0.1:9229，可以--inspect=9229 修改端口。

--inspect-brk 断在第一行

监听客户端必须知道ip，端口和UUID。上述生成的地址是ws://127.0.0.1:9229/3a1eaae7-2ede-4b96-b803-93675a055b59

如果不能用--inspect 参数启动，也可以在Linux或OSX下发送SIGUSR1信号，node8 以上会启动Inspector API，监听调试端口。

Inspector 协议还提供一个Http端点，以获取 WebSocket URL, UUID, 和 Chrome DevTools URL。
地址是 `http://[host:port]/json/list`

访问 http://127.0.0.1:9229/json/list

```
[ {
  "description": "node.js instance",
  "devtoolsFrontendUrl": "chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=127.0.0.1:9229/3a1eaae7-2ede-4b96-b803-93675a055b59",
  "faviconUrl": "https://nodejs.org/static/favicon.ico",
  "id": "3a1eaae7-2ede-4b96-b803-93675a055b59",
  "title": "index.js",
  "type": "node",
  "url": "file:///Users/zhouhh/git/uringsig/index.js",
  "webSocketDebuggerUrl": "ws://127.0.0.1:9229/3a1eaae7-2ede-4b96-b803-93675a055b59"
} ]
```

# 调试工具
## [node-inspect](https://github.com/nodejs/node-inspect)
- CLI Debugger 采用 Inspector Protocol协议，由Nodejs 基金会支持.
- Node有自带版本. 使用方式 `node inspect myscript.js`
- 最新版可以独立安装(e.g. `npm install -g node-inspect`) 使用方式： `node-inspect myscript.js`.
## [Chrome DevTools 55+](https://github.com/ChromeDevTools/devtools-frontend)
- Option 1: 在Chrome浏览器打开 chrome://inspect  点击 Configure 按钮，确定host和端口在列表中。
- Option 2: 从上述host和端口/json/list复制 devtoolsFrontendUrl 或 --inspect 提示信息，并复制到Chrome.
- Option 3: 安装 Chrome Extension NIM (Node Inspector Manager): https://chrome.google.com/webstore/detail/nim-node-inspector-manage/gnhhdgbaldcilmgcpfddgdbkhjohddkj
- 用浏览器打开类似如下的地址。替换UUID。NIM的插件可以自动打开该地址。
`chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=localhost:9229/871f491a-1e34-41ae-b987-fccf2b7017a8`
## Visual Studio Code 1.10+
- 在 Debug 控制面板, 点击 settings 图标，打开 .vscode/launch.json. 
- 点击 "Node.js" 进行初始配置.

## Visual Studio 2017
- 选择 "Debug > Start Debugging" 或快捷键 F5.
- [详细命令](https://github.com/Microsoft/nodejstools/wiki/Debugging)
##  JetBrains WebStorm 2017.1+ 及 JetBrains IDE族
- 创建 Node.js 调试配置 点击 Debug.   Node.js 7+ 缺省会使用--inspect参数. 如果要禁止，取消IDE注册表里面的 js.debugger.node.use.inspect 
## [chrome-remote-interface](https://github.com/cyrus-and/chrome-remote-interface)
- 简化链接到 Inspector Protocol 端点的库.

# 参考
[nodejs 调试入门](https://nodejs.org/en/docs/guides/debugging-getting-started/)
