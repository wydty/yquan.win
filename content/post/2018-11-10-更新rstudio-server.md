---
title: 更新Rstudio Server
author: quan
date: '2018-11-10'
slug: update-rstudio-server
categories:
  - R
tags:
  - rstudio
---

- [rstudio最新版下载地址](https://www.rstudio.com/products/rstudio/download-server/)
- [设置不同R内核](https://support.rstudio.com/hc/en-us/articles/200486138-Using-Different-Versions-of-R)
- [Rstudio 参考书]( http://docs.rstudio.com/ide/server-pro/r-sessions.html#r-executable-and-libraries)
 
安装新版本的R

```sh
# R更新 加源 公钥
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key 51716619E084DAB9
gpg -a --export 51716619E084DAB9 | sudo apt-key add -

# 更新 安装 依赖
sudo apt-get update
sudo apt-get install r-base r-base-dev
sudo apt-get install gdebi-core libapparmor1

# R包 tidyverse 安装
sudo apt-get install libssl-dev libxml2-dev libcurl4-openssl-dev
install.packages("tidyverse")
```

安装Rstudio server：
```sh
# wget http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb
# gdebi rstudio-server-0.97.551-amd64.deb
wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
sudo gdebi rstudio-server-1.1.383-amd64.deb
#完成安装后，RStudio Server会自动启动运行
```

可以直接登录网址使用，127.0.0.1:8787 或 内网IP:8787
如果出现问题，查看下面解决办法

```sh
ps -aux|grep rstudio  #8787端口被打开
#如有问题诊断
sudo rstudio-server verify-installation

#如果装了防火墙,把则手动打开8787
sudo iptables -A INPUT -p tcp --dport 8787 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 8787 -j ACCEPT
iptables -L -n  # 查看是否添加上了


#root用户无法登陆，新建一个用户进行登陆 
#下面命令在root下执行
useradd -d /home/R -m R
#创建用户的同时指定主目录 
passwd R2017
#设置密码

```

主要有两个配置文件，默认文件不存在 
/etc/rstudio/rserver.conf 
/etc/rstudio/rsession.conf

```sh
#设置端口和ip控制:
vi /etc/rstudio/rserver.conf
#监听端口
www-port=8080
#允许访问的IP地址，默认0.0.0.0
www-address=127.0.0.0
#R的安装位置，如果有多个版本R，可以在这设置
rsession-which-r=/usr/local/bin/R

#会话配置管理
vi /etc/rstudio/rsession.conf
session-timeout-minutes=30      #会话超时时间
r-cran-repos=http://ftp.ctex.org/mirrors/CRAN#CRAN资源库

#重启服务器，生效
rstudio-server restart

```


### 系统管理
```sh
ps -aux|grep rstudio
netstat -anp| grep 8787

rstudio-server start #启动
rstudio-server stop #停止
rstudio-server restart #重启

#查看运行中R进程
rstudio-server active-sessions

#指定PID，停止运行中的R进程
rstudio-server suspend-session <pid>

#停止所有运行中的R进程
rstudio-server  suspend-all

#强制停止运行中的R进程，优先级最高，立刻执行
rstudio-server force-suspend-session <pid>
rstudio-server force-suspend-all

#RStudio Server #临时下线，不允许web访问，并给用户友好提示
rstudio-server offline

#RStudio Server #临时上线
rstudio-server online
```
- 参考  http://blog.csdn.net/lovelovelovelovelo/article/details/51884759 


[Rstudio1.2版](https://www.rstudio.com/products/rstudio/download/preview/)

```
wget https://s3.amazonaws.com/rstudio-ide-build/server/trusty/amd64/rstudio-server-1.2.1206-amd64.deb
sudo gdebi rstudio-server-1.2.1206-amd64.deb 

```