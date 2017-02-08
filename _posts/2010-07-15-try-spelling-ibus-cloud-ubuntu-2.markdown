---
author: abloz
comments: true
date: 2010-07-15 03:52:50+00:00
layout: post
link: http://abloz.com/index.php/2010/07/15/try-spelling-ibus-cloud-ubuntu-2/
slug: try-spelling-ibus-cloud-ubuntu-2
title: ubuntu 试用ibus云拼音
wordpress_id: 35
categories:
- 技术
tags:
- ibus
- ubuntu
- 云
---

周海汉 /文 2010.7.15

ibus云拼音为 Linux / ibus 设计的一个支持在线云拼音服务的拼音输入法。下载地址：http://code.google.com/p/ibus-cloud-pinyin/，目前还在开发中。
它采用了sogou和QQ的云拼音服务。同时支持离线输入。介绍见：http://code.google.com/p/ibus-cloud-pinyin/wiki/Intro

ubuntu下目前没有二进制版本，所以直接下载源码。另外不支持图形配置界面，而是lua脚本语言配置，可能会妨碍一部分人使用。<!-- more -->
**
编译**

安装相关开发库：
sudo apt-get install liblua5.1-0-dev liblua5.1-socket2 libsqlite3-dev libibus-dev libnotify-dev lua5.1 libgee-dev valac sqlite3
下载源码：
svn checkout http://ibus-cloud-pinyin.googlecode.com/svn/trunk/ ibus-cloud-pinyin

zhouhh@zhh64:~$ cd ibus-cloud-pinyin/
编译：
zhouhh@zhh64:~/ibus-cloud-pinyin$ make
编译过程中看到有下载一个大离线词库：
:: Creating ibus compoment xml file ...
:: Downloading open-phrase database ...
--2010-07-15 11:08:50--  http://ibus-cloud-pinyin.googlecode.com/files/pinyin-database-1.2.99.tar.xz
正在解析主机 ibus-cloud-pinyin.googlecode.com... 64.233.183.82
正在连接 ibus-cloud-pinyin.googlecode.com|64.233.183.82|:80... 已连接。
已发出 HTTP 请求，正在等待回应... 200 OK
长度： 7444704 (7.1M) [application/octet-stream]
正在保存至: “pinyin-database-1.2.99.tar.xz”

**安装**：
zhouhh@zhh64:~/ibus-cloud-pinyin$ sudo make install

此时重启，ibus就会有云拼音的选项可以添加了。

**配置双拼**
我用的是自然码双拼，但缺省不支持双拼，必须进入配置文件进行配置：
配置可以参考：
http://code.google.com/p/ibus-cloud-pinyin/wiki/Configuration

zhouhh@zhh64:~$ sudo vi /usr/share/ibus-cloud-pinyin/lua/config.lua

缺省双拼方案是微软拼音，通过：
http://code.google.com/p/ibus-cloud-pinyin/wiki/DoublePinyinScheme
找到自然码的，替换config.lua相应内容：
set_double_pinyin{
['ca'] = 'ca', ['cb'] = 'cou', ['ce'] = 'ce', ['cg'] = 'ceng', ['cf'] = 'cen', ['ci'] = 'ci', ['ch'] = 'cang', ['ck'] = 'cao', ['cj'] = 'can', ['cl'] = 'cai', ['co'] = 'cuo', ['cp'] = 'cun', ['cs'] = 'cong', ['cr'] = 'cuan', ['cu'] = 'cu', ['cv'] = 'cui',
['ba'] = 'ba', ['bc'] = 'biao', ['bg'] = 'beng', ['bf'] = 'ben', ['bi'] = 'bi', ['bh'] = 'bang', ['bk'] = 'bao', ['bj'] = 'ban', ['bm'] = 'bian', ['bl'] = 'bai', ['bo'] = 'bo', ['bn'] = 'bin', ['bu'] = 'bu', ['by'] = 'bing', ['bx'] = 'bie', ['bz'] = 'bei',
['da'] = 'da', ['dc'] = 'diao', ['db'] = 'dou', ['de'] = 'de', ['dg'] = 'deng', ['di'] = 'di', ['dh'] = 'dang', ['dk'] = 'dao', ['dj'] = 'dan', ['dm'] = 'dian', ['dl'] = 'dai', ['do'] = 'duo', ['dq'] = 'diu', ['dp'] = 'dun', ['ds'] = 'dong', ['dr'] = 'duan', ['du'] = 'du', ['dv'] = 'dui', ['dy'] = 'ding', ['dx'] = 'die', ['dz'] = 'dei',
['ga'] = 'ga', ['gb'] = 'gou', ['ge'] = 'ge', ['gd'] = 'guang', ['gg'] = 'geng', ['gf'] = 'gen', ['gh'] = 'gang', ['gk'] = 'gao', ['gj'] = 'gan', ['gl'] = 'gai', ['go'] = 'guo', ['gp'] = 'gun', ['gs'] = 'gong', ['gr'] = 'guan', ['gu'] = 'gu', ['gw'] = 'gua', ['gv'] = 'gui', ['gy'] = 'guai', ['gz'] = 'gei',
['fa'] = 'fa', ['fb'] = 'fou', ['fg'] = 'feng', ['ff'] = 'fen', ['fh'] = 'fang', ['fj'] = 'fan', ['fo'] = 'fo', ['fu'] = 'fu', ['fz'] = 'fei',
['ia'] = 'cha', ['ib'] = 'chou', ['ie'] = 'che', ['id'] = 'chuang', ['ig'] = 'cheng', ['if'] = 'chen', ['ii'] = 'chi', ['ih'] = 'chang', ['ik'] = 'chao', ['ij'] = 'chan', ['il'] = 'chai', ['io'] = 'chuo', ['ip'] = 'chun', ['is'] = 'chong', ['ir'] = 'chuan', ['iu'] = 'chu', ['iv'] = 'chui', ['iy'] = 'chuai',
['ha'] = 'ha', ['hb'] = 'hou', ['he'] = 'he', ['hd'] = 'huang', ['hg'] = 'heng', ['hf'] = 'hen', ['hh'] = 'hang', ['hk'] = 'hao', ['hj'] = 'han', ['hl'] = 'hai', ['ho'] = 'huo', ['hp'] = 'hun', ['hs'] = 'hong', ['hr'] = 'huan', ['hu'] = 'hu', ['hw'] = 'hua', ['hv'] = 'hui', ['hy'] = 'huai', ['hz'] = 'hei',
['ka'] = 'ka', ['kb'] = 'kou', ['ke'] = 'ke', ['kd'] = 'kuang', ['kg'] = 'keng', ['kf'] = 'ken', ['kh'] = 'kang', ['kk'] = 'kao', ['kj'] = 'kan', ['kl'] = 'kai', ['ko'] = 'kuo', ['kp'] = 'kun', ['ks'] = 'kong', ['kr'] = 'kuan', ['ku'] = 'ku', ['kw'] = 'kua', ['kv'] = 'kui', ['ky'] = 'kuai',
['jc'] = 'jiao', ['jd'] = 'jiang', ['ji'] = 'ji', ['jm'] = 'jian', ['jn'] = 'jin', ['jq'] = 'jiu', ['jp'] = 'jun', ['js'] = 'jiong', ['jr'] = 'juan', ['ju'] = 'ju', ['jt'] = 'jue', ['jw'] = 'jia', ['jy'] = 'jing', ['jx'] = 'jie',
['ma'] = 'ma', ['mc'] = 'miao', ['mb'] = 'mou', ['me'] = 'me', ['mg'] = 'meng', ['mf'] = 'men', ['mi'] = 'mi', ['mh'] = 'mang', ['mk'] = 'mao', ['mj'] = 'man', ['mm'] = 'mian', ['ml'] = 'mai', ['mo'] = 'mo', ['mn'] = 'min', ['mq'] = 'miu', ['mu'] = 'mu', ['my'] = 'ming', ['mx'] = 'mie', ['mz'] = 'mei',
['la'] = 'la', ['lc'] = 'liao', ['lb'] = 'lou', ['le'] = 'le', ['ld'] = 'liang', ['lg'] = 'leng', ['li'] = 'li', ['lh'] = 'lang', ['lk'] = 'lao', ['lj'] = 'lan', ['lm'] = 'lian', ['ll'] = 'lai', ['lo'] = 'luo', ['ln'] = 'lin', ['lq'] = 'liu', ['lp'] = 'lun', ['ls'] = 'long', ['lr'] = 'luan', ['lu'] = 'lu', ['lt'] = 'lve', ['lv'] = 'lv', ['ly'] = 'ling', ['lx'] = 'lie', ['lz'] = 'lei',
['na'] = 'na', ['nc'] = 'niao', ['nb'] = 'nou', ['ne'] = 'ne', ['nd'] = 'niang', ['ng'] = 'neng', ['nf'] = 'nen', ['ni'] = 'ni', ['nh'] = 'nang', ['nk'] = 'nao', ['nj'] = 'nan', ['nm'] = 'nian', ['nl'] = 'nai', ['no'] = 'nuo', ['nn'] = 'nin', ['nq'] = 'niu', ['ns'] = 'nong', ['nr'] = 'nuan', ['nu'] = 'nu', ['nt'] = 'nve', ['nv'] = 'nv', ['ny'] = 'ning', ['nx'] = 'nie', ['nz'] = 'nei',
['qc'] = 'qiao', ['qd'] = 'qiang', ['qi'] = 'qi', ['qm'] = 'qian', ['qn'] = 'qin', ['qq'] = 'qiu', ['qp'] = 'qun', ['qs'] = 'qiong', ['qr'] = 'quan', ['qu'] = 'qu', ['qt'] = 'que', ['qw'] = 'qia', ['qy'] = 'qing', ['qx'] = 'qie',
['pa'] = 'pa', ['pc'] = 'piao', ['pb'] = 'pou', ['pg'] = 'peng', ['pf'] = 'pen', ['pi'] = 'pi', ['ph'] = 'pang', ['pk'] = 'pao', ['pj'] = 'pan', ['pm'] = 'pian', ['pl'] = 'pai', ['po'] = 'po', ['pn'] = 'pin', ['pu'] = 'pu', ['py'] = 'ping', ['px'] = 'pie', ['pz'] = 'pei',
['sa'] = 'sa', ['sb'] = 'sou', ['se'] = 'se', ['sg'] = 'seng', ['sf'] = 'sen', ['si'] = 'si', ['sh'] = 'sang', ['sk'] = 'sao', ['sj'] = 'san', ['sl'] = 'sai', ['so'] = 'suo', ['sp'] = 'sun', ['ss'] = 'song', ['sr'] = 'suan', ['su'] = 'su', ['sv'] = 'sui',
['rb'] = 'rou', ['re'] = 're', ['rg'] = 'reng', ['rf'] = 'ren', ['ri'] = 'ri', ['rh'] = 'rang', ['rk'] = 'rao', ['rj'] = 'ran', ['ro'] = 'ruo', ['rp'] = 'run', ['rs'] = 'rong', ['rr'] = 'ruan', ['ru'] = 'ru', ['rv'] = 'rui',
['ua'] = 'sha', ['ub'] = 'shou', ['ue'] = 'she', ['ud'] = 'shuang', ['ug'] = 'sheng', ['uf'] = 'shen', ['ui'] = 'shi', ['uh'] = 'shang', ['uk'] = 'shao', ['uj'] = 'shan', ['ul'] = 'shai', ['uo'] = 'shuo', ['up'] = 'shun', ['ur'] = 'shuan', ['uu'] = 'shu', ['uw'] = 'shua', ['uv'] = 'shui', ['uy'] = 'shuai', ['uz'] = 'shei',
['ta'] = 'ta', ['tc'] = 'tiao', ['tb'] = 'tou', ['te'] = 'te', ['tg'] = 'teng', ['ti'] = 'ti', ['th'] = 'tang', ['tk'] = 'tao', ['tj'] = 'tan', ['tm'] = 'tian', ['tl'] = 'tai', ['to'] = 'tuo', ['tp'] = 'tun', ['ts'] = 'tong', ['tr'] = 'tuan', ['tu'] = 'tu', ['tv'] = 'tui', ['ty'] = 'ting', ['tx'] = 'tie',
['wa'] = 'wa', ['wg'] = 'weng', ['wf'] = 'wen', ['wh'] = 'wang', ['wj'] = 'wan', ['wl'] = 'wai', ['wo'] = 'wo', ['wu'] = 'wu', ['wz'] = 'wei',
['va'] = 'zha', ['vb'] = 'zhou', ['ve'] = 'zhe', ['vd'] = 'zhuang', ['vg'] = 'zheng', ['vf'] = 'zhen', ['vi'] = 'zhi', ['vh'] = 'zhang', ['vk'] = 'zhao', ['vj'] = 'zhan', ['vl'] = 'zhai', ['vo'] = 'zhuo', ['vp'] = 'zhun', ['vs'] = 'zhong', ['vr'] = 'zhuan', ['vu'] = 'zhu', ['vw'] = 'zhua', ['vv'] = 'zhui', ['vy'] = 'zhuai',
['ya'] = 'ya', ['yb'] = 'you', ['ye'] = 'ye', ['yi'] = 'yi', ['yh'] = 'yang', ['yk'] = 'yao', ['yj'] = 'yan', ['yl'] = 'yai', ['yo'] = 'yo', ['yn'] = 'yin', ['yp'] = 'yun', ['ys'] = 'yong', ['yr'] = 'yuan', ['yu'] = 'yu', ['yt'] = 'yue', ['yy'] = 'ying',
['xc'] = 'xiao', ['xd'] = 'xiang', ['xi'] = 'xi', ['xm'] = 'xian', ['xn'] = 'xin', ['xq'] = 'xiu', ['xp'] = 'xun', ['xs'] = 'xiong', ['xr'] = 'xuan', ['xu'] = 'xu', ['xt'] = 'xue', ['xw'] = 'xia', ['xy'] = 'xing', ['xx'] = 'xie',
['za'] = 'za', ['zb'] = 'zou', ['ze'] = 'ze', ['zg'] = 'zeng', ['zf'] = 'zen', ['zi'] = 'zi', ['zh'] = 'zang', ['zk'] = 'zao', ['zj'] = 'zan', ['zl'] = 'zai', ['zo'] = 'zuo', ['zp'] = 'zun', ['zs'] = 'zong', ['zr'] = 'zuan', ['zu'] = 'zu', ['zv'] = 'zui', ['zz'] = 'zei',
['aa'] = 'a', ['ai'] = 'ai', ['an'] = 'an', ['ah'] = 'ang', ['ao'] = 'ao', ['ee'] = 'e', ['ei'] = 'ei', ['en'] = 'en', ['er'] = 'er', ['oo'] = 'o', ['ou'] = 'ou',
['v'] = 'zh', ['i'] = 'ch', ['u'] = 'sh',
}

找到set_switch,去掉前面的--[[ 和后面的 --]]
将double_pinyin = 改为true，保存
set_switch{
default_chinese_mode = true,
default_offline_mode = false,
default_traditional_mode = false,
double_pinyin = true,
background_request = true,
show_raw_in_auxiliary = true,
always_show_candidates = true,
show_pinyin_auxiliary = true,
}

**使用**
重启
在ibus的配置中将云输入加入候选拼音输入法，即可使用。
但感觉输入法智能还不太高，经常将次常用的候选词放在前面。
Technorati 标签: [云拼音 ibus ubuntu](http://technorati.com/tag/%E4%BA%91%E6%8B%BC%E9%9F%B3%20ibus%20ubuntu)


![](http://img.zemanta.com/pixy.gif?x-id=b01cba82-84c5-851b-b8b7-b2190efa6f36)
