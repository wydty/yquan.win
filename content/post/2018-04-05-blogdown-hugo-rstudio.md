+++
title= 'blogdown Hugo netlify Rstudio搭建博客笔记'
author= 'quanquan'
date= '2018-04-05'
slug= 'blogdown-hugo-rstudio'
+++

搭建本博客的教程
hugo驱动，模板hugo-portfolio.
<!--more-->

## 安装所需的包
```r
install.packages('blogdown')
devtools::install_github("rstudio/blogdown") # 开发版有些新功能


# 后面可能需要的包
install.packages('later')
install.packages('miniUI')
install.packages("xaringan")

## 安装hugo
blogdown::install_hugo()
## 如果失败可以下载下来 手动安装
blogdown:::install_hugo_bin("d:/hugo.exe")
```

## github新建一个仓库
```sh
# 克隆到本地
git clone https://github.com/wydty/yquan.win.git
# 或者Rstudio中操作
File > new project >
```

## 修改 .gitignore 文件
有些文件不需要啊上传到github, 比如public，是hugo渲染后的网页， 
我们本地预览就够了，因为在Netlify部署的时候会重新渲染
```
.Rproj.user
.Rhistory
.RData
.Ruserdata
blogdown
.DS_Store
public/
```


## 初始化站点
在上面的文件夹下进行
```r
library(blogdown)
blogdown::new_site() 
#默认样式 lithium https://github.com/jrutheiser/hugo-lithium-theme

## 可以指定其它样式 在这里选 https://themes.gohugo.io/ 然后找到theme的github地址
blogdown::new_site(theme = "gcushen/hugo-academic", theme_example = TRUE)

## 如果装好后感觉不喜欢，可以更换
blogdown::install_theme("coderzh/hugo-pacman-theme", theme_example = TRUE, update_config = TRUE)
```
可以在网站 https://themes.gohugo.io/ 选择主题theme


## 写博客
Rstudio 菜单栏下的 ADDins > new post
出来菜单框，填写相关信息，然后用md 写文章吧。
你的md文件会在content/post文件夹。
点击Rstudio右侧的Git > commit > push.


## netlify设置
netlify(https://app.netlify.com/signup) 使用github授权登录。  

- New site from Git 创建Sites,点GitHub
- Buildcommand 填写 hugo
- publish directory 填写 public 
- 点Deploy site 创建站点  
- Site settings 修改站点名称，我是(yquan)
- 可以把自己购买的域名 指向你设置的域名
- 其它还有很多个性设置
- 然后访问你的博客吧 http://yquan.netlify.com/

设置站点的时候出现了一个hugo 225的错误,   
后来找到一个教程，可能是需要指定一下hugo的版本，
blogdown::hugo_version() 查看hugo版本,  
在项目文件夹下创建一个文件 netlify.toml 并写入：
```
[build]
publish = "public"
command = "hugo"

[context.production.environment]
HUGO_VERSION = "0.38"
HUGO_ENV = "production"
HUGO_ENABLEGITINFO = "true"

[context.split1]
command = "hugo --enableGitInfo"

[context.split1.environment]
HUGO_VERSION = "0.38"
HUGO_ENV = "production"

[context.deploy-preview]
command = "hugo -b $DEPLOY_PRIME_URL"

[context.deploy-preview.environment]
HUGO_VERSION = "0.38"

[context.branch-deploy]
command = "hugo -b $DEPLOY_PRIME_URL"

[context.branch-deploy.environment]
HUGO_VERSION = "0.38"

[context.next.environment]
HUGO_ENABLEGITINFO = "true"
```

## 参考教程  

- https://mp.weixin.qq.com/s/bULo3iv__f-64B_IMsPsnw
- https://alison.rbind.io/post/up-and-running-with-blogdown/



