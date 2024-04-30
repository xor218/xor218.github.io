---
layout: default
title: "cmake打印构建过程showConfigu配置"
---

## 显示配置好的信息
	cmake -S. -Bbuild -La
		La 是显示配置好的信息



## 有一些系统不支持-La

```
	//构建cmake系统里面的详细过程
cmake -S. -Bbuild --trace 

构建过程在标准错误输出里面 2 合并到1 然后过滤全部 打印到cmake.log 里面
cmake -S. -Bbuild --trace 2>&1 | awk '{print}' > cmake.log
打印:后面的到 cmake.log2里面
cat cmake.log | awk -F':' '{print $2}' >cmake.log2
```







编译的时候出现详细的命令

```
cmake  -S. -Bbuild -DCMAKE_VERBOSE_MAKEFILE=ON
```
