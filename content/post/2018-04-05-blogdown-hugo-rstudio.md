---
title: blogdown Hugo Rstudio搭建博客教程
author: quanquan
date: '2018-04-05'
slug: blogdown-hugo-rstudio
categories: []
tags: []
---

## 安装所需的包
```r
install.packages('blogdown')
devtools::install_github("rstudio/blogdown")

install.packages('later')
install.packages('miniUI')
install.packages("xaringan")

blogdown::install_hugo()
## 手动安装
blogdown:::install_hugo_bin("d:/hugo.exe")
```

## 初始化站点
```
library(blogdown)

blogdown::new_site()
## 其它样式
blogdown::new_site(theme = "gcushen/hugo-academic", theme_example = TRUE)


# github创建好的仓库
# git clone https://github.com/wydty/yquan.win.git

```

## 写博客
ADDins > new post

## 修改主题
可以在网站 https://themes.gohugo.io/ 选择

## netlify设置
netlify(https://app.netlify.com/signup) 使用github授权登录。
创建Sites,点GitHub
Buildcommand 填写 hugo
publish directory 填写 public
点Deploy site

参考教程
- https://mp.weixin.qq.com/s/bULo3iv__f-64B_IMsPsnw
