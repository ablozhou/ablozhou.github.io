---
layout: post
title:  "Swarm操作实录"
author: "周海汉"
date:   2021-05-28 22:38:35 +0800
categories: tech
tags:
    - Swarm
    - Ethereum
    - Bee
    - Bee-clef
    - BZZ
    - 挖矿
---

# 概述
本文讲述Swarm客户端Bee运行并挖矿的详细实操。作者：周海汉

Swarm（蜂群） 为以太坊官方存储项目，目前已经独立出来。由以太坊三巨头Vitalik Buterin，Gavin Wood，Jeffrey Wilcke创建。 其目标是实现自主的内容网络存储和web3.0服务，并保护用户隐私。

对应的币为BZZ。客户端程序叫Bee。

本文在Centos 7.6下完成。ubuntu和MacOS可以适当修改相应命令。

## 环境
- CentOS 7.6
- Bee-clef 用于bee客户端私钥和签名管理的程序
- Bee 客户端
- screen：保持远程命令行session的程序
- jq：json美化命令程序

### 设置yum镜像
设为阿里云
```
[root@25 ~]# cd /etc/yum.repos.d/

[root@25 yum.repos.d]# curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
```
### 设置fedoral_epel
解决部分包不存在的问题
如jq安装不了。
```
[root@25 ~]# yum install -y jq
No package jq available.
```

```
cd /etc/pki/rpm-gpg
wget https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
curl -o RPM-GPG-KEY-EPEL-7 https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
```

```
vi /etc/yum.repo.d/epel.repo
```

```ini
[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
failovermethod=priority
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
```
# 安装相关软件
## 安装screen
这是一个让进程不退出的程序
```
[root@25 ~]# yum install -y screen
```
### 创建会话：
如指定会话名称为clef
```
screen -S clef
```
### 恢复：
```
screen -r clef
如果只有一个会话：
screen -r
```
### 查看会话
```
screen -ls
```
遇到错误恢复screen时会出现There is no screen to be resumed matching xxx
执行
```
screen -d xxx
```
再执行恢复
### 退出screen
```
exit
```

### 其他命令和快捷键
将当前在另一个终端attach的会话强制退出，在当前终端接管：screen -d name screen -r name

先利用ctrl-a [ 进入copy mode。在copy mode下可以回滚、搜索、复制就像用使用 vi 一样。在copy mode下有这些快捷键：

- C-b ：Backward、PageUp
- C-f ：Forward、PageDown
- H： High，将光标移至左上角
- L：Low，将光标移至左下角
- 0：移到行首
- $：行末
- w：forward one word，以字为单位往前移
- b：backward one word，以字为单位往后移
- Space： 第一次按为标记区起点，第二次按为终点

按esc退出copy mode。

快捷键
```

Ctrl + a，d #暂离当前会话
Ctrl + a，c #在当前screen会话中创建一个子会话
Ctrl + a，w #子会话列表
Ctrl + a，p #上一个子会话
Ctrl + a，n #下一个子会话
Ctrl + a，0-9 #在第0窗口至第9子会话间切换
ctrl + a，A #给窗口自定义命名
```
## 安装jq
这是linux下json解析工具
jq必须[配置epel.repo库](#设置fedoral_epel)才能安装成功。
```
[root@25 ~]# yum install -y jq

```

## 准备好bee目录
```
mkdir /mnt/bee && cd $_
```

## 安装bee-clef
Clef在法语里是key的意思，用于以太坊客户端账号和私钥key的管理。

Clef本质上是一个独立的交易签名器。Clef 背后的思想是将帐户管理与Geth客户端其它功能分开。Clef通过 IPC 或 HTTP 暴露了一个轻量API，可以被Dapp用作签名工具。

Clef最终目标是代替Geth的节点账号管理，可用来对交易进行签名。Clef可以使DApp不必依赖Geth的帐户管理，当DApp需要对数据（或交易）进行签名时，可以将数据发送给Clef，在经过授权同意后，Clef将把签名返回给DApp。

因为Bee必须自动和快速签署许多交易，
一个单独打包的clef程序bee-clef ，用于处理Bee的签名。它包含了Bee所需的全部特殊配置，以便Clef可以和Bee完全配合工作。

```
[root@25 bee]# wget https://github.com/ethersphere/bee-clef/releases/download/v0.4.12/bee-clef_0.4.12_amd64.rpm

Unable to establish SSL connection.

[root@25 bee]# wget https://github.com/ethersphere/bee-clef/releases/download/v0.4.12/bee-clef_0.4.12_amd64.rpm --no-check-certificate
[root@25 bee]# rpm -ivh bee-clef_0.4.12_amd64.rpm

```
遇到Unable to establish SSL connection. 可以用--no-check-certificate规避


ubuntu需要下载相应deb文件，并用下面的命令安装
```
sudo dpkg -i bee-clef_0.4.12_amd64.deb
```

### 检查bee-clef状态
```
[root@25 bee]# systemctl status bee-clef
Active: active (running) since Wed 2021-05-26 16:05:49 CST; 2min 14s ago
 CGroup: /system.slice/bee-clef.service
           ├─4216 bash /usr/bin/bee-clef-service start
           ├─4224 clef --stdio-ui --keystore /var/lib/bee-clef/keystore --configdir /var/lib/bee-clef --chainid 5 --r...
           └─4225 tee /var/lib/bee-clef/stdout
```
MacOs里面
```
launchctl list | grep swarm-clef
```

### 查看日志
```
journalctl -f -u bee-clef.service
```

### 配置clef
配置文件在
```
/etc/bee-clef/
```
这里不需要修改。

### 数据存储
私钥和数据存在如下目录
```
/var/lib/bee-clef/
```
### 停止bee-clef

停止默认启动的服务，防止冲突
```
systemctl stop bee-clef
```

### 下载启动脚本
```
[root@25 bee]# wget https://raw.githubusercontent.com/ethersphere/bee-clef/master/packaging/bee-clef-service --no-check-certificate
[root@25 bee]# chmod +x bee-clef-service

```

### 用screen 管理clef

创建并进入名字为clef的一个会话

```
screen -S clef
```

### 启动bee-clef

```
[root@25 bee]# ./bee-clef-service start
```
按键盘上的ctrl+a ctrl+d 退出名字为clef的一个会话

# 安装设置Bee 客户端
需要完成下面的事情
1. 设置Bee外部签名程序[Bee Clef](https://docs.ethswarm.org/docs/installation/bee-clef/). (推荐)
1. 安装 Bee 并以服务启动
1. 配置 Bee.
1. 用 gETH 和 gBZZ让你的节点[获取资助](https://docs.ethswarm.org/docs/installation/fund-your-node/)
1. 等待您的支票簿交易完成并更新批存储
1. 检查Bee在工作。

## 安装Bee客户端

```
[root@25 bee]# wget https://github.com/ethersphere/bee/releases/download/v0.6.0/bee_0.6.0_amd64.rpm --no-check-certificate
[root@25 bee]# rpm -ivh bee_0.6.0_amd64.rpm
Logs:   journalctl -f -u bee.service
Config: /etc/bee/bee.yaml
Bee requires an Ethereum endpoint to function. By default is using ws://localhost:8546 ethereum endpoint.
If needed obtain a free Infura account and set:

It is recommended to use external signer with bee.
Check documentation for more info:
- SWAP https://docs.ethswarm.org/docs/installation/manual#swap-bandwidth-incentives
- External signer https://docs.ethswarm.org/docs/installation/bee-clef

After you finish configuration run 'sudo bee-get-addr'.

```
日志里说没有找到本地以太坊客户端或者RPC服务。这里直接采用[infura](https://infura.io/)的测试网。

## 查看Bee状态
```
[root@25 bee]# systemctl status bee.service
```
## 停止Bee服务

```
[root@25 bee]# systemctl stop bee.service
```

## 申请一个[infura](https://infura.io/)节点API
在主页面点击创建项目的入口。
左侧有Ethereum，点击create project。
名字填一个独特的名字如ablo_swarm。
keys面板上endpoint可以选择主网还是测试网。这里选择goerli测试网。
会有projectID和security。
我的projectID：
```
c1a6f66d211046afadbfe6fc351bf53a
```
endpoint信息：
```
https://goerli.infura.io/v3/c1a6f66d211046afadbfe6fc351bf53a
wss://goerli.infura.io/ws/v3/c1a6f66d211046afadbfe6fc351bf53a
```

projectID是公开的，但PROJECT_SECRET 必须保密。

访问方式：
```
curl — user :YOUR-PROJECT-SECRET \
https://<network>.infura.io/v3/YOUR-PROJECT-ID
```

### 获取区块高度
```
curl https://goerli.infura.io/v3/c1a6f66d211046afadbfe6fc351bf53a \
-X POST \
-H "Content-Type: application/json" \
-d '{"jsonrpc":"2.0","method":"eth_blockNumber","params": [],"id":1}'
```
得到回复：
```
{"jsonrpc":"2.0","id":1,"result":"0x4a2249"}
```

### 获取某账号余额
```
curl https://goerli.infura.io/v3/c1a6f66d211046afadbfe6fc351bf53a \
-X POST \
-H "Content-Type: application/json" \
-d '{"jsonrpc":"2.0","method":"eth_getBalance","params": ["0xf50D9ecC857d00f93B223359dBcd1793aEEF6429","latest"],"id":1}'
```
返回结果如下

如无充值：
```
{"jsonrpc":"2.0","id":1,"result":"0x0"}
```
有值的话：
```
{"jsonrpc":"2.0","id":1,"result":"0x161e78faeed7a00"}
```
## 配置Bee
### 编辑配置文件
```
sudo vi /etc/bee/bee.yaml
sudo systemctl restart bee
```
### 全节点或轻节点
由于Bee在向网络提供服务以交换gBZZ时会占用大量资源，因此默认情况下，Bee节点以轻节点模式启动。要允许您的蜜蜂使用您的网络带宽和计算资源为网络服务并开始兑现支票，请将--full node标志设置为true。
或在bee.yml配置文件中设置：
```
full-node: true
```
### 区块链端点
您的Bee节点必须能够访问以太坊Goerli testnet区块链，以便它能够与您的chequebook合约进行交互和部署。您可以运行自己的[Goerli](https://github.com/goerli/testnet)节点，或者改用已有的服务，推荐[Infura](https://infura.io/)。

默认情况下，Bee期望在ws://localhost:8545. 如改用以太坊RPC提供程序，如下更改配置：
```
swap-endpoint: wss://goerli.infura.io/ws/v3/your-api-key
```
如果要使用节点解析ENS域名，还必须提供以太坊mainnet RPC提供程序的端点。
```
resolver-options: ["https://mainnet.infura.io/v3/<<your-api-key>>"]
```
### debug api
缺省关闭的，需要打开，并重启
```
debug-api-enable: true
debug-api-addr: 127.0.0.1:1635
```
为了安全，1635端口必须被防火墙屏蔽，决不能在外网卡监听，并暴露出去。

### 文件描述符
```
db-open-files-limit: 2000
```

## 获取资助
### 在Discord #faucet频道获取
为了部署它的支票簿和与Swarm互动，你的蜜蜂需要gBZZ和gETH。

首先，找出你的以太坊地址：
```
sudo bee-get-addr
```
或者用这个命令
```
curl -s localhost:1635/addresses | jq .ethereum
```
您的Bee节点需要gBZZ才能正确地与网络交互。为了接收这些，您需要登录到Swarm的Discord，并使用节点的以太坊地址从[#faucet](https://discord.gg/kfKvmZfVfe)水龙头频道请求gBZZ测试Token。

必须键入而不是粘贴如下的命令，并替换您的以太坊地址
```
/faucet sprinkle 0xf50D9ecC857d00f93B223359dBcd1793aEEF6429
```
机器人会给出信息
```
Your node 0xf50D9ecC857d00f93B223359dBcd1793aEEF6429 was sprinkled! (half a minute) 
```
可能报错，检查一下配置是否有问题
```
Your node 0xf50D9ecC857d00f93B223359dBcd1793aEEF6429 was not sprinkled because of an error...

You don't have any sprinkles left.

Your node 0xf50D9ecC857d00f93B223359dBcd1793aEEF6429 was already sprinkled
```
### 通过Metamask
用浏览器访问下面的网站，替换接受账号
```
https://bzz.ethswarm.org/?transaction=buy&amount=10&slippage=30&receiver=0xf50D9ecC857d00f93B223359dBcd1793aEEF6429
```
连接到Metamask，并切换到goerli测试网
点网页左下角的"Get G-ETH".

### 其他水龙头
- https://faucet.ethswarm.org/
- https://faucet.goerli.mudit.blog/
- https://gitter.im/goerli/testnet?at=5f7f1d756e0eb84469728b8b

### 查看余额
水龙头地址，查看自己地址有没有交易
```
https://goerli.etherscan.io/address/0x10210572d6b4924af7ef946136295e9b209e1fa0
```
自己地址
```
https://goerli.etherscan.io/address/0xf50D9ecC857d00f93B223359dBcd1793aEEF6429
```

## 启动bee服务
可以直接使用bee start命令，也可以用systemctl命令来启动bee。

bee start使用 ~/.bee.yaml 作为配置文件，~/.bee 作为数据文件夹 systemctl start bee.service使用 /etc/bee/bee.yaml 作为配置文件，/var/lib/bee 作为数据文件夹

刚开始不使用`[root@25 bee]# systemctl start bee.service`，方便定位问题。

命令行可以用下面的方式
```
[root@25 bee]# screen -S bee
[root@25 bee]# bee start --verbosity 5 --swap-endpoint https://goerli.infura.io/v3/c1a6f66d211046afadbfe6fc351bf53a --debug-api-enable --clef-signer-enable --clef-signer-endpoint /var/lib/bee-clef/clef.ipc
--full-node=false

Bee node is booting up for the first time. Please provide a new password.
Password:
Confirm password:
INFO[2021-05-26T18:54:25+08:00] using swarm network address through clef: ca8b3b60048b004a1eb848f7af59f820fb20e80be1a4c504ab4b6d29fc6e0d2e
INFO[2021-05-26T18:54:25+08:00] swarm public key 03ac547b2519bd51fa3d4daa5a5640bf5a31d0e1635fa9dcc2f116e3161aca4336
DEBU[2021-05-26T18:54:25+08:00] new libp2p key created
DEBU[2021-05-26T18:54:25+08:00] new pss key created
INFO[2021-05-26T18:54:25+08:00] pss public key 02cece89c3593f896987f9ba37e3c133069fba8f97e697d3d882e1e7fc850e186b
INFO[2021-05-26T18:54:25+08:00] using ethereum address f50d9ecc857d00f93b223359dbcd1793aeef6429
INFO[2021-05-26T18:54:25+08:00] debug api address: [::]:1635
INFO[2021-05-26T18:54:27+08:00] using default factory address for chain id 5: 73c412512e1ca0be3b89b77ab3466da6a1b9d273
INFO[2021-05-26T18:54:37+08:00] no chequebook found, deploying new one.
WARN[2021-05-26T18:54:38+08:00] cannot continue until there is sufficient ETH (for Gas) and at least 1 BZZ available on f50d9ecc857d00f93b223359dbcd1793aeef6429
WARN[2021-05-26T18:54:38+08:00] learn how to fund your node by visiting our docs at https://docs.ethswarm.org/docs/installation/fund-your-node

```


以上warning说明需要充值gBZZ，在[Discord #faucet](https://discord.com/channels/799027393297514537/841664915218628619) 获取充值。参考[获取资助](#获取资助)
```
TRAC[2021-05-27T10:26:05+08:00] sending transaction 708f661a4119745c3277a32204bd8a9e82325a50753a622c7ca954d8a49ff6db with nonce 0
INFO[2021-05-27T10:26:06+08:00] deploying new chequebook in transaction 708f661a4119745c3277a32204bd8a9e82325a50753a622c7ca954d8a49ff6db
TRAC[2021-05-27T10:26:06+08:00] starting to watch transaction 708f661a4119745c3277a32204bd8a9e82325a50753a622c7ca954d8a49ff6db with nonce 0
INFO[2021-05-27T10:26:22+08:00] deployed chequebook at address eb3fdb6ca2736bcff41255ad70c7fa757bcd20fc
INFO[2021-05-27T10:26:22+08:00] depositing 10000000000000000 token into new chequebook
TRAC[2021-05-27T10:26:23+08:00] sending transaction cf4390dcfe30ce141da60bfb1735b7f9467cdc616963627cab6c1c512baa9ab3 with nonce 1
INFO[2021-05-27T10:26:23+08:00] sent deposit transaction cf4390dcfe30ce141da60bfb1735b7f9467cdc616963627cab6c1c512baa9ab3
TRAC[2021-05-27T10:26:23+08:00] starting to watch transaction cf4390dcfe30ce141da60bfb1735b7f9467cdc616963627cab6c1c512baa9ab3 with nonce 1
INFO[2021-05-27T10:26:40+08:00] successfully deposited to chequebook
INFO[2021-05-27T10:26:40+08:00] using datadir in: '/root/.bee'
INFO[2021-05-27T10:26:40+08:00] database capacity: 1000000 chunks (approximately 20.3GB)
DEBU[2021-05-27T10:26:41+08:00] initializing NAT manager
DEBU[2021-05-27T10:26:48+08:00] NAT manager initialized
```

可能会报如下错误：
```
level=warning msg="failing to connect to clef signer: dial unix /var/lib/bee-clef/clef.ipc: connect: permission denied"
```
clef.ipc通过创建Bee用户并设置权限来保护文件，以便该用户只能使用ipc套接字。

## 查看日志
```
sudo journalctl --lines=100 --follow --unit bee
```
如果出现
Error: open /var/lib/bee/statestore/LOCK: permission denied
或者：msg="failing to connect to clef signer: dial unix /var/lib/bee-clef/clef.ipc: connect: permission denied"

则进入/var/lib/bee，确认下statestore的当前权限组是不是bee
如果不是则修改下

sudo chown bee.bee statestore
sudo systemctl restart bee

## 检查Bee状态
```
[root@25 bee]# systemctl status bee.service
● bee.service - Bee - Ethereum Swarm node
   Loaded: loaded (/usr/lib/systemd/system/bee.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2021-05-26 18:35:49 CST; 9s ago
     Docs: https://docs.ethswarm.org
 Main PID: 11105 (bee)
   CGroup: /system.slice/bee.service
           └─11105 /usr/bin/bee start --config /etc/bee/bee.yaml
May 26 18:40:21 25 bee[11427]: time="2021-05-26T18:40:21+08:00" level=warning msg="failing to connect to clef signer: dial unix /var/lib/bee-clef/clef.ipc: connect: permission denied
```    

```
[root@25 bee]# curl localhost:1633
```
如果返回
```
Ethereum Swarm Bee
```
说明正常监听。
可以用debug api交互

查看节点连接情况
```
[root@25 bee]# curl -s localhost:1635/peers | jq ".peers | length"
22
```
查询当前节点余额
```
curl http://127.0.0.1:1635/balances | jq
```
出票状态
```
[root@25 bee]# curl http://127.0.0.1:1635/chequebook/cheque
{"lastcheques":[]}
```
下载查票脚本
```
wget https://github.com/juu17/swarm-tech-tutorial/raw/master/downloads/cashout.sh
chmod 755 cashout.sh
```
查票
```
./cashout.sh
```
兑换支票

` 重要！不要经常兑现支票！一周一次就足够了！这可以防止和缓解区块链上不必要的拥塞。 `
```
./cashout.sh cashout-all 5
```

# 参考
- https://github.com/juu17/swarm-tech-tutorial
- https://docs.ethswarm.org/docs/installation/bee-clef/
- https://docs.ethswarm.org/docs/installation/install
- [兑换支票](https://docs.ethswarm.org/docs/working-with-bee/cashing-out)
