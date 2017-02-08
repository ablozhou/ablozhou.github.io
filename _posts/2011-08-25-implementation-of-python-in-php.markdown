---
author: abloz
comments: true
date: 2011-08-25 09:42:23+00:00
layout: post
link: http://abloz.com/index.php/2011/08/25/implementation-of-python-in-php/
slug: implementation-of-python-in-php
title: 在php中执行python
wordpress_id: 1370
categories:
- 技术
---

美国人Jon写了个PiP，Python in Php项目，可以实现在php中调用python。Jon 79年出生在新泽西州，毕业于罗切斯特理工，曾于2002年合写 Professional PHP4 Programming
示例：

    
    
    1. Evaluating Python Code from PHP
    
    Result
    test 1 50 60.4
    test 2.208 test
    
    2. Python Object Instantiation
    # module.py
    class TestClass:
        def __init__(self, foo):
            self.foo = foo
    
        def returnInt(self):
            return 1113
    
        def test(self, a, b = 'str'):
            return "a = %d, b = %s" % (a, b)
    
        def returnMe(self):
            return self
    
        def returnTuple(self):
            return (1, "two", 3.0)
    
        def returnList(self):
            return [1, "two", 3.0]
    
        def returnDict(self):
            d = {}
            d['one'] = 1
            d['two'] = 2
            d['three'] = 3
            return d
    
        def p(self, var):
            print var
    returnInt() . "n";
    print $p->test(1, 'bar') . "n";
    
    print $p->foo . "n";
    $p->foo = 987;
    print $p->foo . "n";
    
    # $copy points to the same object
    $copy = $p->returnMe();
    print $copy->foo . "n";
    $p->foo = 987;
    print $copy->foo . "n";
    ?>
    Result
    1113
    a = 1, b = bar
    435
    987
    987
    987
    
    3. Type Conversion
    returnTuple());
    var_dump($p->returnList());
    var_dump($p->returnDict());
    
    $a = array('one' => 1, 2, 3);
    $p->p($a);
    
    class Test {
        var $member = 'test';
    }
    
    $t = new Test();
    $p->p($t);
    ?>
    Result
    array(3) {
      [0]=>
      int(1)
      [1]=>
      string(3) "two"
      [2]=>
      float(3)
    }
    array(3) {
      [0]=>
      int(1)
      [1]=>
      string(3) "two"
      [2]=>
      float(3)
    }
    array(3) {
      ["three"]=>
      int(3)
      ["two"]=>
      int(2)
      ["one"]=>
      int(1)
    }
    {'1': 3, '0': 2, 'one': 1}
    {'member': 'test'}
    
    



不过，如果不采用PiP这样的方式，也可以考虑用php的system()和popen(),proc_open()来调用。
如果要执行用户脚本，一定要注意安全。可以用escapeshellarg（）和escapeshellcmd（）或类似preg_replace('/[^a-zA-Z0-9]/', '', $str)去掉无关字符。

PiP官方页面：
http://www.csh.rit.edu/~jon/projects/pip/
