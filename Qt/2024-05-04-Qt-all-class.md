---
layout: post
author: "大西瓜"
title: "all of qt class"
date:   2024-05-04 22:14:16 +0800
categories: [update,Qt] 
---



# 把安装路径添加到CMAKE_PREFIX_PATH里面
list(APPEND CMAKE_PREFIX_PATH "/Users/yourUserName/Qt/6.2.4/macos")

# 安装路径可以用qmake命令
qmake -query QT_INSTALL_PREFIX
