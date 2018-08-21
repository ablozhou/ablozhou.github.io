---
layout: post
title:  "如何生成es6项目"
author: "周海汉"
date:   2018-08-21 19:28:26 +0800
categories: tech
tags:
    - javascript
    - ES6
    - node-inspect
    - nodejs
    - babel

---

# 概述
本文描述了生成一个ES6项目的基本步骤。

# 初始化和安装

```bash
mkdir nodejs-es6
npm init y
touch index.js
npm install --save express
npm install --save-dev babel-cli babel-preset-es2015 rimraf
```

 package.js
```
{
  "name": "nodejs-es6",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
     "build": "rimraf dist/ && babel ./ --out-dir dist/ --ignore ./node_modules,./.babelrc,./package.json,./npm-debug.log --copy-files",
   "start": "npm run build && node dist/index.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.15.3"
  },
  "devDependencies": {
    "babel-cli": "^6.24.1",
    "babel-preset-es2015": "^6.24.1",
    "rimraf": "^2.6.1"
  }
}
```
.babelrc
```
{
  "presets": ["es2015"]
}
```

index.js
```
import express from 'express';

const app = express()

app.get('/', function (req, res) {
  res.send('Hello World!')
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})

```

# 执行
node index.js

可以通过浏览器访问http://localhost:3000 ，显示hello world。
