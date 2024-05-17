---
layout: post
author: "大西瓜"
title: "pkg-config"
date:   2024-05-05 10:54:57 +0800
categories: [update,LinuxCommand] 
---
```bash
NAME
       pkg-config - Return metainformation about installed libraries
					返回已安装库的元信息

SYNOPSIS
       pkg-config [--modversion] [--version] [--help] [--atleast-pkgconfig-version=VERSION] [--print-errors] [--short-
       errors] [--silence-errors] [--errors-to-stdout] [--debug] [--cflags] [--libs] [--libs-only-L] [--libs-only-l]
       [--cflags-only-I] [--libs-only-other] [--cflags-only-other] [--variable=VARIABLENAME] [--define-
       variable=VARIABLENAME=VARIABLEVALUE] [--print-variables] [--uninstalled] [--exists] [--atleast-version=VERSION]
       [--exact-version=VERSION] [--max-version=VERSION] [--validate] [--list-all] [--print-provides] [--print-
       requires] [--print-requires-private] [LIBRARIES...]

说明
       pkg-config 程序用于获取系统中已安装库的信息。  它是
       通常用于针对一个或多个库进行编译和链接。  下面是一个
       Makefile：

       程序： program.c
            cc program.c `pkg-config --cflags --libs gnomeui`

       pkg-config 从特殊的元数据文件中获取有关软件包的信息。这些文件以
       软件包，扩展名为 .pc。  在大多数系统中，pkg-config 位于 /usr/lib/pkgconfig、
       /usr/share/pkgconfig、/usr/local/lib/pkgconfig 和 /usr/local/share/pkgconfig 以获取这些文件。  它将
       此外，它还会在以冒号分隔（在 Windows 系统中，以分号分隔）的目录列表中查找由
       PKG_CONFIG_PATH 环境变量。

       在 pkg-config 命令行中指定的软件包名称被定义为元数据文件的名称，减去
       .pc 扩展名。如果一个库可以同时安装多个版本，则必须为每个版本提供自己的
       名称（例如，GTK 1.2 的软件包名称可能是 "gtk+"，而 GTK 2.0 则是 "gtk+-2.0"）。

       除了在命令行中指定软件包名称外，还可以给出指定 .pc 文件的完整路径
       而不是.pc。这样，用户就可以直接查询特定的 .pc 文件。
```


```bash

HOW USE:
	pkg-config 会搜索环境变量 PKG_CONFIG_PATH 指定的目录，如果没有指定，则会搜索默认目录
		/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig
	如果没有找到，则会报错
	如果自己要添加到搜索目录 可以执行环境变量 
	export PKG_CONFIG_PATH=/your/path/to/add/to/pkgcon:$PKG_CONFIG_PATH


```


```bash
EXAMPLE:
		
		gcc file.c `pkg-config --cflags --libs openssl`
		

		`pkg-config --cflags --libs openssl ` 
		 会被当成命令先解析
		 -I/opt/homebrew/Cellar/openssl@3/3.2.1/include -L/opt/homebrew/Cellar/openssl@3/3.2.1/lib -lssl -lcrypto

		会被解析成
			gcc file.c	-I/opt/homebrew/Cellar/openssl@3/3.2.1/include -L/opt/homebrew/Cellar/openssl@3/3.2.1/lib -lssl -lcrypto

```