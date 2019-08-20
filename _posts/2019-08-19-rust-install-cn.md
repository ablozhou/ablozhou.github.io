---
layout: post
title:  "国内安装Rust环境"
author: "周海汉"
date:   2019-08-19 22:28:26 +0800
categories: tech
tags:
    - Rust
    - 镜像

---

# 问题
Rustup 是 Rust 官方的跨平台 Rust 安装工具。
第一次安装 rustup 的时候，如果按照官网教程 https://sh.rustup.rs 链接无法下载，可以通过 jsdelivr 下载 rustup-init.sh， 然后把脚本中的 RUSTUP_UPDATE_ROOT 变量改为 https://mirrors.ustc.edu.cn/rust-static/rustup
如果有问题也可以用http协议。

# 下载脚本和初始文件
如执行帮助里的脚本不能安装，可以通过浏览器直接下载这两个文件
```
https://sh.rustup.rs
https://mirrors.ustc.edu.cn/rust-static/rustup/dist/x86_64-apple-darwin/rustup-init
```

但从ustc下载也经常socket超时。
可以直接用浏览器下载rustup-init.

# rustup-init.sh修改
修改rustup-init.sh的脚本，将_file指到手工下的该文件。
```
RUSTUP_UPDATE_ROOT="http://mirrors.ustc.edu.cn/rust-static/rustup"

local _file="./rustup-init${_ext}"

    # ignore rm "$_file"
    # ignore rmdir "$_dir"

```
同时，注释掉下载该文件的语句。
可以将rm rustup-init文件和目录的语句也注释掉。

执行rustup-init就会自动安装。
清华也提供了rust的镜像。
中科大的镜像不知是何原因，安装会socket超时。改为清华镜像就没有问题了。

具体在.zshrc或.bashrc中，将RUSTUP_DIST_SERVER进行修改，由原来
```
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
```
改为：
```
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
```

执行
```
sh rustup-init.sh
```

```
zhouhh@/Users/zhouhh $ rustc --version
rustc 1.36.0 (a53f9df32 2019-07-03)
zhouhh@/Users/zhouhh/rust $ cargo --version
cargo 1.36.0 (c4fcfb725 2019-05-15)
zhouhh@/Users/zhouhh/rust $ cargo new hello
 Created binary (application) `hello` package

zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ find ./*
./Cargo.toml
./src
./src/main.rs
zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ cargo run
   Compiling hello v0.1.0 (/Users/zhouhh/rust/hello)
    Finished dev [unoptimized + debuginfo] target(s) in 5.75s
     Running `target/debug/hello`
Hello, world!

zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ cargo build
    Finished dev [unoptimized + debuginfo] target(s) in 0.05s
zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ ./target/debug/hello
Hello, world!
zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ cargo build --release
   Compiling hello v0.1.0 (/Users/zhouhh/rust/hello)
    Finished release [optimized] target(s) in 1.04s
zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ rustc src/main.rs
zhouhh@/Users/zhouhh/rust/hello git:(master) ✗ $ ./main
Hello, world!
```

# 参考
- [清华镜像帮助](https://mirrors.tuna.tsinghua.edu.cn/help/rustup/)
- [中科大镜像帮助](https://mirrors.ustc.edu.cn/help/rust-static.html)
- [原版英文书](https://doc.rust-lang.org/book/)
- [中文版书](https://rustlang-cn.org/office/rust/book/)
