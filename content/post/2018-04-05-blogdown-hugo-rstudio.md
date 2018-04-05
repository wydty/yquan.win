---
title: blogdown Hugo Rstudio搭建博客教程
author: quanquan
date: '2018-04-05'
slug: blogdown-hugo-rstudio
categories: []
tags: []
---

## 安装所需的包
```
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

