---
author: abloz
comments: true
date: 2016-01-29 16:24:06+00:00
layout: post
link: http://abloz.com/index.php/2016/01/30/mybatis3-mapping-maps-and-notation-note-comparison-test/
slug: mybatis3-mapping-maps-and-notation-note-comparison-test
title: mybatis3  mapping映射和notation注解对比测试
wordpress_id: 2726
categories:
- 未分类
tags:
- maven
- mybatis
- natation
- postgres
- spring
---

周海汉 2016.1.29


基于spring4.2.2，maven3.3, mybatis 3.3, postgres 数据库，实现用户表的读写查询。下面是实例代码。

pom.xml

    
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.abloz</groupId>
        <artifactId>websvr</artifactId>
        <packaging>war</packaging>
        <version>0.0.1-SNAPSHOT</version>
        <name>websvr Maven Webapp</name>
        <url>http://maven.apache.org</url>
        <properties>
            <java.version>1.8</java.version>
            <spring.version>4.2.2.RELEASE</spring.version>
            <jackson.version>2.4.0</jackson.version>
        </properties>
        <dependencyManagement>
            <dependencies>
                <!-- "bill of materials" (BOM) dependency, not need include versions of spring -->
                <dependency>
                    <groupId>org.springframework</groupId>
                    <artifactId>spring-framework-bom</artifactId>
                    <version>${spring.version}</version>
                    <type>pom</type>
                    <scope>import</scope>
                </dependency>
            </dependencies>
        </dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.12</version>
                <scope>test</scope>
            </dependency>
            <!-- Spring dependencies -->
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-core</artifactId>
                <exclusions>
                    <exclusion>
                        <groupId>commons-logging</groupId>
                        <artifactId>commons-logging</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
    
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-web</artifactId>
            </dependency>
    
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-webmvc</artifactId>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-tx</artifactId>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-aop</artifactId>
            </dependency>
    
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-beans</artifactId>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-jdbc</artifactId>
            </dependency>
    
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-context</artifactId>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-test</artifactId>
            </dependency>
    
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis</artifactId>
                <version>3.3.0</version>
            </dependency>
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid</artifactId>
                <version>1.0.16</version>
            </dependency>
    
            <dependency>
                <groupId>commons-dbcp</groupId>
                <artifactId>commons-dbcp</artifactId>
                <version>1.2.2</version>
            </dependency>
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>5.1.38</version>
            </dependency>
            <dependency>
                <groupId>postgresql</groupId>
                <artifactId>postgresql</artifactId>
                <version>9.1-901-1.jdbc4</version>
            </dependency>
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis-spring</artifactId>
                <version>1.2.3</version>
            </dependency>
            <dependency>
                <groupId>org.aspectj</groupId>
                <artifactId>aspectjweaver</artifactId>
                <version>1.8.7</version>
            </dependency>
            <dependency>
                <groupId>com.fasterxml.jackson.core</groupId>
                <artifactId>jackson-core</artifactId>
                <version>${jackson.version}</version>
            </dependency>
            <dependency>
                <groupId>com.fasterxml.jackson.core</groupId>
                <artifactId>jackson-annotations</artifactId>
                <version>${jackson.version}</version>
            </dependency>
            <!-- for convert java pojo to json -->
            <dependency>
                <groupId>com.fasterxml.jackson.core</groupId>
                <artifactId>jackson-databind</artifactId>
                <version>${jackson.version}</version>
            </dependency>
    
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>fastjson</artifactId>
                <version>1.2.7</version>
            </dependency>
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>javax.servlet-api</artifactId>
                <version>3.1-b08</version>
            </dependency>
            <dependency>
                <groupId>log4j</groupId>
                <artifactId>log4j</artifactId>
                <version>1.2.16</version>
            </dependency>
    
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>jcl-over-slf4j</artifactId>
                <version>1.5.8</version>
            </dependency>
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-api</artifactId>
                <version>1.5.8</version>
            </dependency>
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-log4j12</artifactId>
                <version>1.5.8</version>
            </dependency>
            <dependency>
                <groupId>jstl</groupId>
                <artifactId>jstl</artifactId>
                <version>1.2</version>
            </dependency>
            <dependency>
                <groupId>taglibs</groupId>
                <artifactId>standard</artifactId>
                <version>1.1.2</version>
            </dependency>
    
            <!-- file upload -->
            <dependency>
                <groupId>commons-fileupload</groupId>
                <artifactId>commons-fileupload</artifactId>
                <version>1.3.1</version>
            </dependency>
            <dependency>
                <groupId>commons-io</groupId>
                <artifactId>commons-io</artifactId>
                <version>2.4</version>
            </dependency>
            <dependency>
                <groupId>commons-codec</groupId>
                <artifactId>commons-codec</artifactId>
                <version>1.9</version>
            </dependency>
    
            <!-- poi相关配置 -->
            <!-- 解析xls类型 -->
            <dependency>
                <groupId>org.apache.poi</groupId>
                <artifactId>poi</artifactId>
                <version>3.13</version>
            </dependency>
            <!-- 解析xlsx类型 -->
            <dependency>
                <groupId>org.apache.poi</groupId>
                <artifactId>poi-ooxml</artifactId>
                <version>3.13</version>
            </dependency>
    
        </dependencies>
    
        <build>
            <finalName>websvr</finalName>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.3</version>
                    <configuration>
                        <source>${java.version}</source>
                        <target>${java.version}</target>
                        <encoding>UTF-8</encoding>
                    </configuration>
                </plugin>
            </plugins>
    
            <resources>
                <resource>
                    <directory>src/main/java</directory>
                    <includes>
                        <include>**/*.properties</include>
                        <include>**/*.xml</include>
                    </includes>
                    <filtering>false</filtering>
                </resource>
                <resource>
                    <directory>src/main/resources</directory>
                    <includes>
                        <include>**/*.properties</include>
                        <include>**/*.xml</include>
                    </includes>
                    <filtering>false</filtering>
                </resource>
            </resources>
        </build>
        <organization>
            <name>zc</name>
        </organization>
    </project>
    


spring-mybatis.xml

    
    <?xml version="1.0" encoding="UTF-8"?>
    <beans xmlns="http://www.springframework.org/schema/beans" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:tx="http://www.springframework.org/schema/tx" 
    xmlns:aop="http://www.springframework.org/schema/aop" 
    xmlns:mybatis="http://mybatis.org/schema/mybatis-spring" 
    xmlns:context="http://www.springframework.org/schema/context"   
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans 
        http://www.springframework.org/schema/beans/spring-beans-4.2.xsd 
        http://www.springframework.org/schema/tx 
        http://www.springframework.org/schema/tx/spring-tx-4.2.xsd
        http://www.springframework.org/schema/aop 
        http://www.springframework.org/schema/aop/spring-aop-4.2.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-4.2.xsd
        http://mybatis.org/schema/mybatis-spring
        http://mybatis.org/schema/mybatis-spring.xsd
    ">
        <!-- 自动扫描以减少xml配置 -->
        <context:component-scan base-package="com.abloz"></context:component-scan>
        
        <context:property-placeholder location="classpath:dbconfig2.properties" />
    
        <!-- ===========================配置数据源============================ -->
       <bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource"> 
           <property name="driverClassName" value="${jdbc.driverClassName}"> 
           </property> 
           <property name="url" value="${jdbc.url}"> </property> 
           <property name="username" value="${jdbc.username}"></property> 
           <property name="password" value="${jdbc.password}"></property> 
        </bean> 
        
        <!-- =======================针对myBatis的配置项===================== -->
        <!-- 配置sqlSessionFactory -->
        <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
           <property name="dataSource" ref="dataSource" />
            
            <!-- 自动扫描/com/abloz/mapping/目录下的所有SQL映射的xml文件, 省掉Config.xml里的手工配置
            value="classpath:com/abloz/mapping/*.xml"指的是classpath(类路径)下com.abloz.mapping包中的所有xml文件
             -->
             
            <property name="mapperLocations" value="classpath*:com/zc/mapping/*.xml" />
            <property name="typeAliasesPackage" value="com.abloz.bean" />
          </bean>
        
        <!-- 配置dao扫描器 spring 自动查找其下的类-->
        <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
            <!-- 扫描com.abloz.dao这个包以及它的子包下的所有映射接口类 -->
            <property name="basePackage" value="com.abloz.dao" />
            <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory" />
        </bean>
        
        <!-- 配置Spring的事务管理器 -->
        <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
            <property name="dataSource" ref="dataSource" />
        </bean>
    
        <!-- 注解方式配置事务 -->
        <tx:annotation-driven transaction-manager="transactionManager" /> 
    </beans>


dbconfig2.properties

    
    jdbc.driverClassName=org.postgresql.Driver
    jdbc.url=jdbc:postgresql://192.168.1.10/mydb
    jdbc.username=dbuser
    jdbc.password=xxx


mapper.xml. 这是实现自动映射的xml文件

    
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE 
    mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
     "http://mybatis.org/dtd/mybatis-3-mapper.dtd"> 
     
     <!-- 为这个mapper指定一个唯一的namespace，namespace的值习惯上设置成包名+sql映射文件名，这样就能够保证namespace的值是唯一 -->
     <mapper namespace="com.abloz.dao.UserDao">
     <!-- 在select标签中编写查询的SQL语句， 设置select标签的id属性为getUser，id属性值必须是唯一的，不能够重复
        使用parameterType属性指明查询时使用的参数类型，resultType属性指明查询返回的结果集类型
        resultType="com.abloz.bean.User"就表示将查询结果封装成一个User类的对象返回
        User类就是users表所对应的实体类
        -->
        <!-- 
            根据id查询得到一个user对象
         -->
        <select id="getUserById" parameterType="int" 
            resultType="User">
            select * from zc_user where id=#{id}
        </select>
        
     	<select id="getAllUsers" resultType="User">
     		select * from zc_user 
     	</select>
     	
     	<select id="countAll" resultType="int">
     		select count(*) c from zc_user
     	</select>
     	
     	<select id="getUserByName" parameterType="String" resultType="User">
     		select * from zc_user where name=#{name}
     	</select>
     	
     	<select id="getUserByNameAndPwd" parameterType="map" resultType="User">
     		select * from zc_user where name=#{userName} and password=#{password}
     	</select>
     	
     	<insert id="insert" parameterType="User">
     		insert into zc_user(id,name,password) values(#{id},#{name},#{password})
     	</insert>
     	
     	<insert id="insertUsers"  parameterType="java.util.List">
    	
    		insert into zc_user (name,password) values
    		<foreach collection="list" item="item" index="index" separator="," >
    			(#{item.name},#{item.password})
    		</foreach>
    	</insert>
        <!-- 创建表 -->
        <insert id="creatTable" parameterType="java.util.Map" statementType="STATEMENT">
            create table if not exists ${tablename}
            <foreach collection="fields" item="k" index="index" open="(" separator="," close=");">
                ${k} ${fields[k]}
            </foreach>
       </insert>
    	<insert id="creatTableAndInsert" parameterType="java.util.Map" statementType="STATEMENT">
            create table if not exists ${tablename}
            <foreach collection="keys" item="k" index="index" open="(" separator="," close=");">
                ${k} varchar(30) not null
            </foreach>
            insert into ${tablename}
            <foreach collection="keys" item="k" index="index" open="(" separator="," close=")">
                ${k}
            </foreach>
            values
            <foreach collection="keys" item="k" index="index" open="(" separator="," close=")">
                '${params[k]}'
            </foreach>
        </insert>
     	<update id="update" parameterType="User">
    		update zc_user 
    		<set>
    		<!-- 这里要注意后面的逗号“，”  因为有多个参数需要用逗号隔开  否则会报错 -->
    			<if test="name!=null">name=#{name},</if>
    			<if test="password!=null">password=#{password}</if>
    		</set>
    			where id=#{id}
     	</update>
     	
     	<delete id="delete" parameterType="int">
     		delete from zc_user where id=#{id}
     	</delete>
     </mapper>


数据库

    
    create table zc_user (id serial primary key, name text, password text);
    


User.java

    
    /** 
    * 
    * @author Andy Zhou/周海汉  
    * @date：2016年1月12日 上午6:02:54 
    *  
    */ 
    package com.abloz.bean;
    
    public class User {
        private int id;
        private String name;
        private String password;
        
        public User() {
            
        }
        
        public User(int id, String name, String password) {
            super();
            this.id = id;
            this.name = name;
            this.password = password;
        }
        
        public int getId() {
            return id;
        }
        public void setId(int id) {
            this.id = id;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
        public String getPassword() {
            return password;
        }
        public void setPassword(String password) {
            this.password = password;
        }
        @Override
        public String toString() {
            return "User [id=" + id + ", name=" + name + ", password=" + password + "]";
        }
        
        
    
    }
    




UserDao.java

    
    /** 
    * 
    * @author Andy Zhou/周海汉  
    * @date：2016年1月12日 上午6:02:54   
    */
    package com.abloz.dao;
    
    import java.util.List;
    
    import org.apache.ibatis.annotations.Param;
    import org.springframework.stereotype.Repository;
    
    import com.abloz.bean.*;
    
    @Repository
    public interface UserDao {
    
        /*
         * 查询
         */
        public List<User> getAllUsers();
    
        public User getUserById(int id);
    
        public List<User> getUserByName(String userName);
    
    	public User getUserByNameAndPwd(@Param("userName") String userName, @Param("password") String password);
    
    	public int countAll();
    	
        /*
         * 更新删除插入
         */
        public int insert(User user);
    
        public int update(User user);
    
        public int delete(int id);
    
        /*
         * 批处理 插入多条数据 
         */
        public void insertUsers(List<User> users);
    
    }


采用注解的UserDao1.java

    
    /** 
    * 
    * @author Andy Zhou/周海汉  
    * @date：2016年1月12日 上午6:02:54 
    * 注解版mybatis用户数据映射
    */
    package com.abloz.dao;
    
    import java.text.MessageFormat;
    import java.util.List;
    import java.util.Map;
    
    import org.apache.ibatis.annotations.Delete;
    import org.apache.ibatis.annotations.Insert;
    import org.apache.ibatis.annotations.InsertProvider;
    import org.apache.ibatis.annotations.Param;
    import org.apache.ibatis.annotations.Select;
    import org.apache.ibatis.annotations.Update;
    import org.apache.log4j.Logger;
    import org.springframework.stereotype.Repository;
    
    import com.abloz.bean.*;
    
    /**
     * 
     * UserDao1
     * Anotation version for UserDao
     */
    @Repository
    public interface UserDao1 {
    
        /*
         * 查询
         */
        @Select("select * from zc_user order by name asc")
        public List<User> getAllUsers();
    
        @Select("select * from zc_user where id=#{id} order by name asc")
        public User getUserById(int id);
    
        @Select("select * from zc_user where name=#{name} order by name asc")
        public List<User> getUserByName(@Param("name") String userName);
        
        @Select("select * from zc_user where name = #{name} and password=#{password} order by name asc")
    	public User getUserByNameAndPwd(@Param("name") String userName, @Param("password") String password);
    
    	@Select("select count(*) c from zc_user;")
    	public int countAll();
    	
        /*
         * 更新删除插入
         */
    	@Insert("insert into zc_user(id,name,password) values (#{id},#{name},#{password})")
        public int insert(User user);
    
        @Update("update zc_user set name=#{name},password=#{password} where name=#{name}")
        public int update(User user);
    
        @Delete("delete from zc_user where id=#{id}")
        public int delete(int id);
        
        @Delete("delete from zc_user where name=#{name}")
        public int deleteByName(String name);
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
    
    }


单元测试文件

    
    /** 
    * @title UnitTestBase.java
    * @author Andy Zhou/周海汉  
    * @date：2016年1月26日 上午11:17:56 
    *  
    */ 
    package com.abloz.test;
    
    import static org.junit.Assert.assertNotNull;
    
    import org.apache.log4j.Logger;
    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.context.ApplicationContext;
    import org.springframework.test.context.ContextConfiguration;
    import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
    
    /**
     * UnitTestBase
     * 
     */
    @RunWith(SpringJUnit4ClassRunner.class)
    @ContextConfiguration({"classpath*:/spring-mybatis.xml"})
    public class UnitTestBase {
        protected static Logger logger = Logger.getLogger(UnitTestBase.class);
        
        @Autowired
        private ApplicationContext ac;
      
        @Test
        public void test() {
            assertNotNull(ac);
        }
        
        public Object getBean(String beanName) {
            return ac.getBean(beanName);
        }
    }
    



    
    /** 
    * @Title UserDaoTest.java
    * @author Andy Zhou/周海汉  
    * @date：2016年1月12日 下午2:35:33 
    *  
    */
    package com.abloz.test;
    
    
    import java.util.ArrayList;
    import java.util.List;
    
    import javax.annotation.Resource;
    
    import org.junit.After;
    import org.junit.Assert;
    import org.junit.Before;
    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.springframework.test.annotation.Rollback;
    import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
    import org.springframework.transaction.annotation.Transactional;
    
    import com.abloz.bean.User;
    import com.abloz.dao.UserDao;
    
    /**
     * UserDaoTest
     * 
     */
    @RunWith(SpringJUnit4ClassRunner.class)
    @Transactional
    public class UserDaoTest extends UnitTestBase {
        
        @Resource
        UserDao ud = null;
        
        int id;
        String name;
        String passwd;
    
        /**
         * @throws java.lang.Exception
         */
        @Before
        public void setUp() throws Exception {
            id=10;
            name = "郭靖";
            passwd="123456";
            User user = new User(id, name , passwd );
            ud.insert(user);
        }
    
        /**
         * @throws java.lang.Exception
         */
        @After
        public void tearDown() throws Exception {
            ud.delete(id);
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao#getAllUsers()}.
         */
        @Test
        public void testGetAllUsers() {
            List<User> users = ud.getAllUsers();
            logger.debug("users:" + users);
            Assert.assertTrue(users.size() > 0);
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao#getUserById(int)}.
         */
        @Test
        public void testGetUserById() {
            User u = ud.getUserById(id);
            logger.debug("user:" + u);
            Assert.assertNotNull(u);
        }
    
        /**
         * Test method for
         * {@link com.abloz.dao.UserDao#getUserByUserName(java.lang.String)}.
         */
        @Test
        public void testGetUserByName() {
            List<User> u = ud.getUserByName(name);
            logger.debug("user:" + u);
            Assert.assertNotNull(u.size()>0);
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao#countAll()}.
         */
        @Test
        public void testCountAll() {
            int userCount = ud.countAll();
            List<User> allUsers = ud.getAllUsers();
            Assert.assertEquals(userCount, allUsers.size());
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao#insert(com.abloz.bean.User)}.
         */
        @Test
        @Rollback(true)
        public void testInsert() {
            
             User user = new User(id+1, name, "123456");
             int insertResult = ud.insert(user);
             Assert.assertEquals(1, insertResult);
        }
    
        // /**
        // * Test method for {@link com.abloz.dao.UserDao#update(com.abloz.bean.User)}.
        // */
        @Test
        @Rollback(true)
        public void testUpdate() {
            User user = ud.getUserById(id);
            user.setName(name);
            user.setPassword("654321");
            int updateResult = ud.update(user);
            Assert.assertEquals(1, updateResult);
        }
    
        // /**
        // * Test method for {@link com.abloz.dao.UserDao#delete(java.lang.String)}.
        // */
        @Test
        @Rollback(true)
        public void testDelete() {
            User user = new User(id+1, name, "123456");
            ud.insert(user);
            int delResult = ud.delete(id+1);
    
            Assert.assertEquals(1, delResult);
        }
    
        // /**
        // * Test method for {@link com.abloz.dao.UserDao#insertUsers(java.util.List)}.
        // */
        @Test
        @Rollback(true)
        public void testInsertUsers() {
             //Insert 
             User u1 = new User(0, "杨过", "p1");
             User u2 = new User(0, "小龙女", "p2");
             ArrayList<User> users = new ArrayList<User>();
             users.add(u1);
             users.add(u2);
            
             ud.insertUsers(users);
    
        }
    
    }
    



    
    /** 
    * @title UserDao11Test.java
    * @author Andy Zhou/周海汉  
    * @date：2016年1月27日 下午6:58:34 
    *  
    */ 
    package com.abloz.dao;
    
    import static org.junit.Assert.*;
    
    import java.util.ArrayList;
    import java.util.List;
    
    import javax.annotation.Resource;
    
    import org.junit.After;
    import org.junit.Assert;
    import org.junit.Before;
    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.springframework.test.annotation.Rollback;
    import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
    import org.springframework.transaction.annotation.Transactional;
    
    import com.abloz.bean.User;
    import com.abloz.test.UnitTestBase;
    
    /**
     * UserDao11Test
     * 
     */
    @RunWith(SpringJUnit4ClassRunner.class)
    @Transactional
    public class UserDao1Test extends UnitTestBase {
    
        @Resource
        UserDao1 ud = null;
        
        int id;
        String name;
        String passwd;
    
        /**
         * @throws java.lang.Exception
         */
        @Before
        public void setUp() throws Exception {
            id=10;
            name = "郭靖";
            passwd="123456";
            User user = new User(id, name , passwd );
            ud.insert(user);
        }
    
        /**
         * @throws java.lang.Exception
         */
        @After
        public void tearDown() throws Exception {
            ud.delete(id);
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao1#getAllUsers()}.
         */
        @Test
        //@Rollback(true)
        public void testGetAllUsers() {
            List<User> users = ud.getAllUsers();
            logger.debug("users:" + users);
            Assert.assertTrue(users.size() > 0); 
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao1#getUserById(int)}.
         */
        @Test
        public void testGetUserById() {
            User u = ud.getUserById(id);
            logger.debug("user:" + u);
            Assert.assertNotNull(u);
        }
    
        /**
         * Test method for
         * {@link com.abloz.dao.UserDao1#getUserByUserName(java.lang.String)}.
         */
        @Test
        public void testGetUserByName() {
            List<User> u = ud.getUserByName(name);
            logger.debug("user:" + u);
            Assert.assertNotNull(u.size()>0);
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao1#countAll()}.
         */
        @Test
        public void testCountAll() {
            int userCount = ud.countAll();
            List<User> allUsers = ud.getAllUsers();
            Assert.assertEquals(userCount, allUsers.size());
        }
    
        /**
         * Test method for {@link com.abloz.dao.UserDao1#insert(com.abloz.bean.User)}.
         */
        @Test
        @Rollback(true)
        public void testInsert() {
            
             User user = new User(id+1, name, "123456");
             int insertResult = ud.insert(user);
             Assert.assertEquals(1, insertResult);
        }
    
        // /**
        // * Test method for {@link com.abloz.dao.UserDao1#update(com.abloz.bean.User)}.
        // */
        @Test
        @Rollback(true)
        public void testUpdate() {
            User user = ud.getUserById(id);
            user.setName(name);
            user.setPassword("654321");
            int updateResult = ud.update(user);
            Assert.assertEquals(1, updateResult);
        }
    
        // /**
        // * Test method for {@link com.abloz.dao.UserDao1#delete(java.lang.String)}.
        // */
        @Test
        @Rollback(true)
        public void testDelete() {
            User user = new User(id+1, name, "123456");
            ud.insert(user);
            int delResult = ud.delete(id+1);
    
            Assert.assertEquals(1, delResult);
        }
    
        // /**
        // * Test method for {@link com.abloz.dao.UserDao1#insertUsers(java.util.List)}.
        // */
        @Test
        @Rollback(true)
        public void testInsertUsers() {
             //Insert 
             User u1 = new User(0, "杨过", "p1");
             User u2 = new User(0, "小龙女", "p2");
             ArrayList<User> users = new ArrayList<User>();
             users.add(u1);
             users.add(u2);
            
             ud.insertUsers(users);
    
        }
    
    
    }
    





