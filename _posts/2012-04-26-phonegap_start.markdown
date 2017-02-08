---
author: abloz
comments: true
date: 2012-04-26 08:31:27+00:00
layout: post
link: http://abloz.com/index.php/2012/04/26/phonegap_start/
slug: phonegap_start
title: 写一次代码，运行在所有移动平台
wordpress_id: 1554
categories:
- 技术
tags:
- android
- ios
- phonegap
- windows phone
---

http://abloz.com
author:周海汉
date:2012.4.26

ios,android,windows phone，symbian四个主流移动平台，代码相差较大，往往需要几套人马来开发各不同平台的内容。一直想，如果有一个类似网页开发的平台，开发一次，就像应用一样在各不同智能手机上运行，那该多好!
正好有这么一个项目，Apache 的哥多华(cordova)平台下的phonegap，可以满足这样的期望。而且还超出期望，除了支持上述四个主流智能平台，还支持black berry，hp的webos，甚至三星的基于linux的bada移动平台。而且能生成各平台独立的安装程序，可以在各大应用市场上进行推广。

先在android平台上来个[hello word](http://phonegap.com/start#android)试试!
**准备：**
平台准备：
[eclipse j2ee](http://www.eclipse.org/downloads/)版本，
安装最新版[android sdk](http://developer.android.com/sdk/index.html)，
安装最新eclipse android开发插件[ADT](http://developer.android.com/sdk/eclipse-adt.html#installing)，
下载最新的[phonegap开发包](http://phonegap.com/download)。
我下的是[phonegap-phonegap-1.7.0rc1-0-g1564354.zip](http://phonegap.com/download)

**安装phonegap**
启动Eclipse，然后在菜单“File”下选择新建android项目，取名hellopgap
在生成的项目根目录下建
/libs
/assets/www
两个目录
将解压的phonegap的libandroid下的cordova-1.7.0rc1.js拷贝到/assets/www
将xml目录拷贝到hellopgap下的/res目录
将cordova-1.7.0rc1.jar拷贝到/libs下面
刷新eclipse项目，将libs下的cordova-1.7.0rc1.jar，add to build path

**代码修改**
根据不同的phonegap版本，可能不完全一样。
到2012.4.26最新的代码修改方法：

修改com.abloz.hellogap下的HellopgapActivity.java
注释import android.app.Activity
增加import org.apache.cordova.*;
将Activity改为DroidGap
注释setContentView(R.layout.main);
增加
super.loadUrl("file:///android_asset/www/index.html");
如下所示：

```


    
    package com.abloz.hellogap;
    
    //import android.app.Activity;
    import android.os.Bundle;
    import org.apache.cordova.*;
    public class HellopgapActivity extends DroidGap {
        /** Called when the activity is first created. */
        @Override
        public void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            super.loadUrl("file:///android_asset/www/index.html");
            //setContentView(R.layout.main);
        }
    }



```

在/assets/www下新建index.html
复制如下代码：

```


    
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <title>你好，世界!</title>
        <meta name="author" content="周海汉" />
    	<script type="text/javascript" charset="utf-8" src="cordova-1.7.0rc1.js"></script>
    </head>
    <body>
    <h1>你好，移动世界!</h1>
    </body>
    </html>


你好，移动世界!


```

修改
AndroidManifest.xml
增加

```


    
    <supports-screens
    android:largeScreens="true"
    android:normalScreens="true"
    android:smallScreens="true"
    android:resizeable="true"
    android:anyDensity="true"
    />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_LOCATION_EXTRA_COMMANDS" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECEIVE_SMS" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.READ_CONTACTS" />
    <uses-permission android:name="android.permission.WRITE_CONTACTS" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />



```

和

```


    
           <activity android:name="org.apache.cordova.DroidGap" android:label="@string/app_name" android:configChanges="orientation|keyboardHidden">
    		<intent-filter> </intent-filter>
    	   </activity>
        </application>



```

并修改第一个Activity的属性，增加
android:configChanges="orientation|keyboardHidden"
最终如下：

```


    
    <?xml version="1.0" encoding="utf-8"?>
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.abloz.hellogap"
        android:versionCode="1"
        android:versionName="1.0" >
     <supports-screens
    android:largeScreens="true"
    android:normalScreens="true"
    android:smallScreens="true"
    android:resizeable="true"
    android:anyDensity="true"
    />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_LOCATION_EXTRA_COMMANDS" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECEIVE_SMS" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.READ_CONTACTS" />
    <uses-permission android:name="android.permission.WRITE_CONTACTS" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
        <uses-sdk android:minSdkVersion="10" />
    
        <application
            android:icon="@drawable/ic_launcher"
            android:label="@string/app_name" >
            <activity
                android:name=".HellopgapActivity"
                android:label="@string/app_name"
                android:configChanges="orientation|keyboardHidden"
                >
                <intent-filter>
                    <action android:name="android.intent.action.MAIN" />
    
                    <category android:name="android.intent.category.LAUNCHER" />
                </intent-filter>
            </activity>
           <activity android:name="org.apache.cordova.DroidGap" android:label="@string/app_name" android:configChanges="orientation|keyboardHidden">
    		<intent-filter> </intent-filter>
    	   </activity>
        </application>
    
    </manifest>



```

**运行**
在项目上右键，运行为android application，会在模拟器或手机中看到全屏的Hello world几个打字。
并且bin下也生成了hellopgap.apk。这是我的google galaxy nexus上运行的画面：
[![](http://abloz.com/wp-content/uploads/2012/04/pgap.png)](http://abloz.com/wp-content/uploads/2012/04/pgap.png)
**参考：**
下载：http://phonegap.com/download
入门示例：http://phonegap.com/start
源代码：https://github.com/phonegap/phonegap
中文网站：http://www.phonegap.cn
阿帕奇哥多华平台：http://incubator.apache.org/cordova/
