---
author: abloz
comments: true
date: 2016-01-29 16:42:44+00:00
layout: post
link: http://abloz.com/index.php/2016/01/30/error-handling-for-spring4-and-mybatis3/
slug: error-handling-for-spring4-and-mybatis3
title: spring4 和mybatis3 报的错误处理
wordpress_id: 2730
categories:
- 技术
tags:
- mybatis
- spring
---

周海汉 2016.1.29

    
    org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.type.TypeException: Could not set parameters for mapping: ParameterMapping{property='name', mode=IN, javaType=int, jdbcType=null, numericScale=null, resultMapId='null', jdbcTypeName='null', expression='null'}. Cause: org.apache.ibatis.type.TypeException: Error setting non null for parameter #1 with JdbcType null . Try setting a different JdbcType for this parameter or a different configuration property. Cause: org.postgresql.util.PSQLException: 栏位索引超过许可范围：1，栏位数：0。
        at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:76)
        at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:399)
        at com.sun.proxy.$Proxy27.delete(Unknown Source)
        at org.mybatis.spring.SqlSessionTemplate.delete(SqlSessionTemplate.java:285)
        at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:58)
        at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:53)
        at com.sun.proxy.$Proxy38.delete(Unknown Source)
        at com.zc.dao.UserDao1Test.tearDown(UserDao1Test.java:59)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:497)
        at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
        at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
        at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
        at org.junit.internal.runners.statements.RunAfters.evaluate(RunAfters.java:33)


原因：

    
       //这一句引起上述错误
        @Delete("delete from zc_user where name='#{name}'")
        public int delete(int id);
    
    
         //正确的应该为
        @Delete("delete from zc_user where id=#{id}")
        public int delete(int id);





* * *




    
    org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.type.TypeException: Could not set parameters for mapping: ParameterMapping{property='name', mode=IN, javaType=class java.lang.String, jdbcType=null, numericScale=null, resultMapId='null', jdbcTypeName='null', expression='null'}. Cause: org.apache.ibatis.type.TypeException: Error setting non null for parameter #1 with JdbcType null . Try setting a different JdbcType for this parameter or a different configuration property. Cause: org.postgresql.util.PSQLException: 栏位索引超过许可范围：1，栏位数：0。
        at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:76)
        at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:399)
        at com.sun.proxy.$Proxy28.selectList(Unknown Source)
        at org.mybatis.spring.SqlSessionTemplate.selectList(SqlSessionTemplate.java:205)
        at org.apache.ibatis.binding.MapperMethod.executeForMany(MapperMethod.java:122)
        at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:64)
        at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:53)
        at com.sun.proxy.$Proxy39.getUserByName(Unknown Source)
        at com.zc.dao.UserDao1Test.testGetUserByName(UserDao1Test.java:91)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:497)
        at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
        at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
        at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
        at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
        at org.junit.internal.runners.statements.RunBefores.evaluate(RunBefores.java:26)



    
    //引起上述错误的语句：
        @Select("select * from zc_user where name='#{name}' order by name asc")
        public List<User> getUserByName(String name);
    
    不能加单引号，正确为：
        @Select("select * from zc_user where name=#{name} order by name asc")
        public List<User> getUserByName(String name);





* * *




    
    org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.builder.BuilderException: Error invoking SqlProvider method (com.zc.dao.UserDao1$UserDao1Provider.insertUsers).  Cause: java.lang.reflect.InvocationTargetException
        at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:76)
        at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:399)
        at com.sun.proxy.$Proxy28.insert(Unknown Source)
        at org.mybatis.spring.SqlSessionTemplate.insert(SqlSessionTemplate.java:253)
        at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:52)
        at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:53)
        at com.sun.proxy.$Proxy39.insertUsers(Unknown Source)
        at com.zc.dao.UserDao1Test.testInsertUsers(UserDao1Test.java:157)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:497)
        at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
        at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
        at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
        at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
        at org.junit.internal.runners.statements.RunBefores.evaluate(RunBefores.java:26)
       。。。
    Caused by: org.apache.ibatis.binding.BindingException: Parameter 'users' not found. Available parameters are [collection, list]
        at org.apache.ibatis.session.defaults.DefaultSqlSession$StrictMap.get(DefaultSqlSession.java:294)
        at com.zc.dao.UserDao1$UserDao1Provider.insertUsers(UserDao1.java:78)
        ... 58 more


将

    
    List<User> users = map.get("list");


list参数改为users犯的上述错误

    
     /*
         * 批处理 插入多条数据 
         */
        @InsertProvider(type = UserDao1Provider.class, method = "insertUsers")
        public void insertUsers(List<User> users);
        
     
        public static class UserDao1Provider {
            protected static Logger logger = Logger.getLogger(UserDao1Provider.class);
             
            public String insertUsers(Map<String, List<User>> map) {
                //default map key is "list", @Param redefine it to "users"
                List<User> users = map.get("list");
                StringBuilder sb = new StringBuilder();
                sb.append("insert into  zc_user ");
                sb.append("(name, password) ");
                sb.append("values ");
                //MessageFormat 不允许左{, 单引号可以使其保持原样。右大括号}则允许。
                MessageFormat mf = new MessageFormat("(#'{'list[{0}].name},#'{'list[{0}].password})");
                for (int i = 0; i < users.size(); i++) {
                    sb.append(mf.format(new Integer[]{i}));
                    sb.append(",");
                }
                //remove last ','
                sb.setLength(sb.length() - 1);
                
                //the sql like:
                //INSERT INTO User (name,password) VALUES (#{list[0].name},#{list[0].password}), (#{list[1].name},#{list[1].password})
                //[,(#{list[i].name},#{list[i].password})] 
                logger.info("insertUsers:"+sb.toString());
                return sb.toString();
            }
     
        }





