---
author: abloz
comments: true
date: 2015-05-27 10:22:58+00:00
layout: post
link: http://abloz.com/index.php/2015/05/27/java-total-reflection-configuration-parameters/
slug: java-total-reflection-configuration-parameters
title: java完全配置参数的反射
wordpress_id: 2299
categories:
- 技术
tags:
- java
---

周海汉 2015.5.27

Java的反射很强大，以致可以通过xml直接生成类。本文想模拟一下完全参数化的反射方式。

Car类：

```


    
    package com.abloz;
    
    public class Car {
    
    private String name;
    
    privateintspeed;
    
    public Car() {
    
    }
    
    public Car(String name, int speed) {
    
    this.name = name;
    
    this.speed = speed;
    
    }
    
    public String getName() {
    
    returnname;
    
    }
    
    public void setName(String name) {
    
    this.name = name;
    
    }
    
    public int getSpeed() {
    
    returnspeed;
    
    }
    
    public void setSpeed(int speed) {
    
    this.speed = speed;
    
    }
    
    @Override
    
    public String toString() {
    
    return "Car [name=" + name + ", speed=" + speed + "]";
    
    }
    
    }



```

参数类：

```


    
    package com.abloz;
    
    public class Param {
    
    public Param(Class<?> clazz, Object value) {
    
    this.clazz = clazz;
    
    this.value = value;
    
    }
    
    public Class<?> clazz;
    
    public Object value;
    
    @Override
    
    public String toString() {
    
    return "Param [clazz=" + clazz + ", value=" + value + "]";
    
    }
    
    }



```

参数集合容器：

```


    
    package com.abloz;
    
    import java.util.ArrayList;
    
    import java.util.List;
    
    public class Params {
    
    private List<Param> params = new ArrayList<Param>();
    
    public List<Param> getParams() {
    
    returnparams;
    
    }
    
    public void add(Param param) {
    
    params.add(param);
    
    }
    
    @Override
    
    public String toString() {
    
    return "Params [params=" + params + "]";
    
    }
    
    }



```

最关键的反射类，实现了一种简单的和一种完全参数化的反射方式

```


    
    package com.abloz;
    
    import java.lang.reflect.Constructor;
    
    import java.lang.reflect.Field;
    
    import java.lang.reflect.InvocationTargetException;
    
    import java.lang.reflect.Method;
    
    import java.util.Map;
    
    import java.util.Map.Entry;
    
    public class ReflectCar {
    
    public static void reflect1() {
    
    ClassLoader loader =  Thread.currentThread().getContextClassLoader();
    
    try {
    
    //反射法初始化类
    
    Class clazz = loader.loadClass("com.abloz.Car");
    
    Constructor cons = clazz.getConstructor((Class[])null);
    
    Car car = (Car) cons.newInstance((Class[])null);
    
    //反射法调用方法
    
    Method method = clazz.getMethod("setName",String.class );
    
    method.invoke(car, "my reflect car");
    
    Method speedMethod = clazz.getMethod("setSpeed",int.class);
    
    speedMethod.invoke(car,500);
    
    System.out.println("reflect car1:"+car);
    
    } catch (ClassNotFoundException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (NoSuchMethodException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (SecurityException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (InstantiationException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (IllegalAccessException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (IllegalArgumentException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (InvocationTargetException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    }
    
    }
    
    public static void reflect2(String className, Map<String,Params> methods) {
    
    ClassLoader loader =  Thread.currentThread().getContextClassLoader();
    
    try {
    
    //反射法初始化类
    
    Class clazz = loader.loadClass(className);
    
    Constructor cons = clazz.getConstructor((Class[])null);
    
    Car car = (Car) cons.newInstance((Class[])null);
    
    //反射法调用方法
    
    for(Entry<String,Params> entry : methods.entrySet()) {
    
    Params params = entry.getValue();
    
    for(Param p :params.getParams()) {
    
    Method method = clazz.getMethod(entry.getKey(), p.clazz);
    
    method.invoke(car, p.value);
    
    }
    
    }
    
    System.out.println("reflect car2:"+car);
    
    } catch (ClassNotFoundException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (NoSuchMethodException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (SecurityException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (InstantiationException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (IllegalAccessException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (IllegalArgumentException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    } catch (InvocationTargetException e) {
    
    // TODO Auto-generated catch block
    
    e.printStackTrace();
    
    }
    
    }
    
    }



```

测试类：

```


    
    package com.abloz;
    
    import java.util.HashMap;
    
    import java.util.Map;
    
    public class TestCar {
    
    public static void main(String[] args) {
    
    //1. 普通的调用
    
    Car car = new Car("mycar1",100);
    
    System.out.println("normal car:"+car);
    
    //2. 普通的反射, 还需要知道类的很多信息
    
    ReflectCar.reflect1();
    
    //3.完全盲调用，类名，方法名，参数类型和参数完全通过配置，如通过xml。  但这个还没解决多参数问题。
    
    Map<String,Params> methods = new  HashMap<String,Params>();
    
    Params params = new Params();
    
    params.add(new Param(String.class,"my reflect car haha"));
    
    methods.put("setName", params);
    
    params = new Params();
    
    params.add(new Param(int.class,1000));
    
    methods.put("setSpeed", params);
    
    ReflectCar.reflect2("com.abloz.Car", methods);
    
    }
    
    }



```

执行后输出：


normal car:Car [name=mycar1, speed=100]




reflect car1:Car [name=my reflect car, speed=500]




reflect car2:Car [name=my reflect car haha, speed=1000]


参考：

http://sishuok.com/forum/blogPost/list/4229.html


