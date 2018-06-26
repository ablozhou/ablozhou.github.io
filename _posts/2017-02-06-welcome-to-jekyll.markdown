---
layout: post
title:  "从wordpress移植到Jekyll!"
date:   2017-02-06 20:17:26 +0800
categories: 技术 
---

# 安装 jekyll
```
sudo gem install jekyll

➜  ~ jekyll --version
jekyll 3.4.0
```
安装 bundler. 它是管理其他gem兼容性的.
```
➜  ~ sudo gem install bundler
ERROR:  While executing gem ... (Errno::EPERM)
    Operation not permitted - /usr/bin/bundle

vi .zshrc

    export GEM_HOME=$HOME/ruby
    export PATH=$PATH:$GEM_HOME/bin


gem install bundler
bundle install
jekyll new blog
➜  blog ls
Gemfile      Gemfile.lock _config.yml  _posts       _site        about.md     index.md
➜  blog jekyll serve
```
修改theme
```
➜  blog bundle show minima
/Users/zhouhh/ruby/gems/minima-2.1.0
```
静态html页面,直接在跟目录下创建html文件或者创建子目录,下面存放html文件.
[使用原始html页面](http://jekyllrb.com/docs/pages/)

# theme定制

# wordpress导入
[导入工具](http://import.jekyllrb.com/docs/usage/)
```
gem install jekyll-import
```
以下这两种, 我没有使用, 而是用了第三方的exitwp
```
ruby -rubygems -e 'require "jekyll-import";
JekyllImport::Importers::Blogger.run({
        "source"                => "/Users/zhouhh/blog/abloz.com.17.2.2.xml",
        "no-blogger-info"       => true, # not to leave blogger-URL info (id and old URL) in the front matter
        "replace-internal-link" => false, # replace internal links using the post_url liquid tag.
        })'


ruby -rubygems -e 'require "jekyll-import";
JekyllImport::Importers::WordPress.run({
        "dbname"   => "abloz_wp",
        "user"     => "root",
        "password" => "",
        "host"     => "localhost",
        "socket"   => "",
        "table_prefix"   => "wp_",
        "site_prefix"    => "",
        "clean_entities" => true,
        "comments"       => true,
        "categories"     => true,
        "tags"           => true,
        "more_excerpt"   => true,
        "more_anchor"    => true,
        "extension"      => "html",
        "status"         => ["publish"]
        })'

Whoops! Looks like you need to install 'sequel' before you can use this importer.

If you're using bundler:
1. Add 'gem "sequel"' to your Gemfile
2. Run 'bundle install'

If you're not using bundler:
1. Run 'gem install sequel'.

Whoops! Looks like you need to install 'unidecode' before you can use this importer.

If you're using bundler:
1. Add 'gem "unidecode"' to your Gemfile
2. Run 'bundle install'

If you're not using bundler:
1. Run 'gem install unidecode'.
```

                                                                                                                                                ➜  blog vi Gemfile
                                                                                                                                                gem "sequel"
                                                                                                                                                gem "unidecode"
                                                                                                                                                gem 'mysql2',"0.4.5"

                                                                                                                                                ➜  blog bundle install

# exitwp 将wordpress.xml转为markdown

## 下载 exitwp
git clone https://github.com/ablozhou/exitwp.git

 pip install pyyaml

 将wordpress.xml复制到wordpress-xml目录下
 python exitwp.py

 中间可能需要解决一些问题, 如果格式不对等. 直接编辑wordpress.xml

 将生成的_build目录下的abloz.com目录复制到jekyll的blog目录

# 提交github
```
git init
git add remote origin https://github.com/ablozhou/ablozhou.github.io

git pull origin master
From https://github.com/ablozhou/ablozhou.github.io
 * branch            master     -> FETCH_HEAD
 fatal: refusing to merge unrelated histories

 ➜  blog git:(master) git pull origin master --allow-unrelated-histories

 git add .
 git commit -m "初始化 "
 git push
```

# 配置dns
配置dns, 将域名的cname配置为
ablozhou.github.io
包括@和www

# 源码里面也需创建CNAME, 并提交到github
➜  blog git:(master) cat CNAME
abloz.com
www.abloz.com


