---
title: Programming with R学习笔记
author: quan
date: '2019-03-14'
slug: programming-with-r-note
categories: [R]
tags: []
---

课程地址：https://swcarpentry.github.io/r-novice-inflammation/


## 1.导入数据，简单统计
```
class(dat) #数据类型
dim(dat) #维度

# apply允许我们在数据框的所有行（MARGIN = 1）或列（MARGIN = 2）上重复一个函数。
apply(dat, 1, mean)
```

## 2.创建函数

在R中，没有必要包含return语句。R自动返回函数体最后一行的变量,将注释放在函数的开头，以便为该函数提供帮助。

确切地说，R有三种方式，您提供的参数与函数定义的形式参数匹配：按完整名称，然后通过部分匹配名称，最后按位置匹配。

## 3.分析多个数据集

for 循环
使用list.files(path = "path", pattern = "pattern", full.names = TRUE)创建的文件名匹配的模式列表。

## 4.做出选择 if else

使用if (condition)启动条件语句，else if (condition)以提供额外的测试，并else提供一个默认值。
条件语句的主体必须用花括号括起来{ }。
使用==测试相等。
X & Y 只有当X和Y都为真时才是真的。
X | Y 如果X或Y或两者都为真，则为真。

## 5.命令行运行程序

运行R脚本可以直接使用 Rscript命令。
```
Rscript script.R args1 args2
# 功能与下面一样
/lib/R/bin/exec/R
--slave
--no-restore
--file=print-args.R
--args
args1
args2
```
向量中的第一个参数是R可执行文件的路径。以下是影响R行为的所有命令行参数。
--slave：让R尽可能安静地跑
--no-restore：不要还原在R会话期间创建的任何内容
--file：运行此文件
--args：将这些参数传递给正在运行的文件

标准输入读取行file("stdin")
`lines <- readLines(con = file("stdin"))`


## 6.编写R代码的最佳实践

如何编写其他人可以理解和使用的R代码？

- 在代码中使用一致的样式。例如，将所有矩阵命名为_mat。一致性使代码更易于阅读，更容易发现问题。
- 将代码保存在块中。如果单个函数或循环变得太长，请考虑寻找将其分解为更小块的方法。
- 不要重复代码,如果您反复重复相同的代码，请使用循环或函数为您重复该代码。不必要的重复不仅浪费时间 - 它还增加了你犯下代价高昂的错误的可能性！
- 将项目的所有源文件保留在同一目录中，然后根据需要使用相对路径来访问它们。  

清理内存的方法：
```
gc() # 强制R释放不再使用的内存
ls() # 列出工作区所有对象
rm(list = ls()) # 删除所有对象
```

## 7.使用 knitr 生成动态报告

knitr是一个R包，允许您在单个文档中组织注释，代码和结果。它是“文学编程 literate programming”的一个很好的工具 ，使用Markdown格式化文本。
RStudio中，创建代码块的键盘快捷键是`Command+ Option+ I`或`Ctrl+ Alt+ I`


## 8.在R中制作包

R包是可重用代码的基本单元。包名只能包含字母和数字，并且必须以字母开头。

R包需要四个组件：  
包含有关包的元数据的描述文件;  
带有代码的R目录;  
带文档的man目录（我们将自动创建）;  
一个NAMESPACE文件列出了包中的用户级功能。 
[参考书](http://r-pkgs.had.co.nz/description.html)

```
# install.packages(c("devtools", "roxygen2"))
library("devtools");library("roxygen2")
setwd(parentDirectory) #设置工作目录
create("tempConvert")  #创建包
```
DESCRIPTION ,手动填写包的信息。
R目录，写一个函数示例。
```
#' Converts Fahrenheit to Kelvin
#'
#' 介绍 This function converts input temperatures in Fahrenheit to Kelvin.
#' @param  参数 temp_F The temperature in Fahrenheit.
#' @return The temperature in Kelvin.
#' @export 导出
#' @examples 示例
#' fahrenheit_to_kelvin(32)

fahrenheit_to_kelvin <- function(temp_F) {
  temp_K <- ((temp_F - 32) * (5/9)) + 273.15
  temp_K
}
```

man目录，roxygen2自动生成文档。
```
document() #roxygen2自动生成文档
install("tempConvert")  #安装，测试
```

每个包都必须有一个DESCRIPTION文件和一个包含代码的R目录。这些都是我们创造的。
还需要一个NAMESPACE文件和一个包含文档的man目录，但两者都可以自动生成。


## 9.RStudio简介

## 10.数据提取

在R对象内部处理数据有三种主要方式。
- 按索引（切片）
- 通过逻辑向量
- 按名称（仅限列）

## 11.读取和写入CSV文件

stringsAsFactors ，R的默认行为是将字符串转换为因子

## 12.理解因子

因子用于表示分类数据。因素可以是有序的或无序的，是统计分析和绘图的重要类别。因子存储为整数，并具有与这些唯一整数相关联的标签。虽然因素看起来（并且通常表现得像）字符向量，但实际上它们是引擎盖下的整数，并且在将它们视为字符串时需要小心。一旦创建，因子只能包含预定义的设置值，称为级别。默认情况下，R始终按字母顺序对级别进行排序。

```
nlevels(sex) #级别数
food <- factor(food, levels = c("low", "medium", "high")) #指定因子顺序
```


## 13.数据类型和结构

R有6个原子矢量类型。  
字符："a"，"swc"  
数字：2，15.5  
整数：2L（所述L告诉R键存储此作为一个整数）  
逻辑：TRUE，FALSE  
复数 :( 1+4i具有实部和虚部的复数）  

R数据结构：atomic vector，list，matrix，data frame，factors

## 14.调用堆栈

## 15.R中的循环

什么是矢量化？
在R中，重复计算时有多个选项：矢量化操作，for循环和apply函数。
记住R中没有标量，所以`b<-5`实际上是长度为1的向量;

apply家族成员包括   
- apply - 应用于数组的边距（例如矩阵的行或列）
- lapply - 申请对象和返回列表
- sapply - 如果可能，应用于对象并返回简化对象（数组）
- vapply- 类似sapply但您指定迭代返回的对象类型


[整套课程讲义](https://swcarpentry.github.io/r-novice-inflammation/aio.html)
[课程总结关键点](https://swcarpentry.github.io/r-novice-inflammation/reference.html)

