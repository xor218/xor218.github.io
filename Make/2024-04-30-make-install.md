---
layout: post
author: "大西瓜"
title: "make install"
date:   2024-04-30 12:48:03 +0800
categories: [update,make] 
---

# make install
	install -m Mode currentBinary target_dir



## 编译器和选项
CC = gcc
CFLAGS = -Wall -Wextra -O2

## 目标文件和目标位置
TARGET = ManPageDump
INSTALL_DIR = /Users/min122218/app/bin

## 默认目标
.PHONY: all
all: $(TARGET)

## 编译规则
$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $@ $^

## 安装规则 -b会老的
.PHONY: install
install: $(TARGET)
	install -b -m 755 $(TARGET) $(INSTALL_DIR)

## 清理规则
.PHONY: clean
clean:
	rm -f $(TARGET)

