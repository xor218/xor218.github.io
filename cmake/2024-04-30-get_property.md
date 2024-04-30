---
layout: default
title: "get_property"
---

## get_property 如何使用

### GitHub Copilot

`get_property` 是 CMake 中的一个命令，用于获取一个属性的值。它的基本语法如下：

```cmake
get_property(VAR <scope> PROPERTY <prop> [SET | DEFINED | BRIEF_DOCS | FULL_DOCS] [INHERITED] [TARGET <tgt> | DIRECTORY <dir> | TEST <test> | SOURCE <src> | INSTALL <file> | CACHE <var>])
```

各个参数的含义如下：

- `VAR`：用于存储获取到的属性值的变量。
- `<scope>`：属性的作用范围，可以是 `GLOBAL`、`DIRECTORY` 或 `TARGET`。
- `<prop>`：要获取的属性的名称。
- `SET`、`DEFINED`、`BRIEF_DOCS` 和 `FULL_DOCS`：这些选项用于获取属性的不同信息。`SET` 用于检查属性是否被设置，`DEFINED` 用于检查属性是否被定义，`BRIEF_DOCS` 和 `FULL_DOCS` 用于获取属性的文档。
- `INHERITED`：这个选项用于获取继承的属性。
- `TARGET <tgt>`、`DIRECTORY <dir>`、`TEST <test>`、`SOURCE <src>`、`INSTALL <file>` 和 `CACHE <var>`：这些选项用于指定要获取属性的目标、目录、测试、源文件、安装文件或缓存变量。

例如，以下的代码获取了一个目标的 `INCLUDE_DIRECTORIES` 属性：

get_property(dirs TARGET MyTarget PROPERTY INCLUDE_DIRECTORIES)



## NOTE

好几种类型

`GLOBAL` 全局 

`TARGET` 目标 

`DIRECTORY` 目录

`CACHE` 缓存



三种类型都有一个名字

可以给这个名字设置属性 取属性

有一些会有隐藏属性，比如目标





##  example 1

```c++
#设置mytestvalue 的值为 hello kitty 放在缓存里面 并且设置数据类型为STRING 注释为nothing 
# //nothing
# mytestvalue:STRING=hello kitty
set(mytestvalue "hello kitty" CACHE STRING "nothing")
  
#从缓存里面取属性放在heihei变量里面 所有的cmakefile都运行完 才会生成完成的缓存文件，要不然就只能取你自己定义的 
get_property(heihei CACHE mytestvalue PROPERTY VALUE)
message(">>>>>>>>>>>>>>${heihei}")
```





## example 2

```cmake
add_executable(a.out main.c)
target_include_directories(a.out PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
	#获取属性，只能取自己自己定义的，不能取代码里面的
	#INCLUDE_DIRECTORIES 为隐藏属性
get_property(dirs TARGET a.out PROPERTY INCLUDE_DIRECTORIES)
message("Include directories of a.out: ${dirs}")
```





## example 3

```cmake
add_executable(a.out main.c)
//设置属性 TARGET 只能大写
set_property(TARGET a.out PROPERTY PNAME "a.out")
//取属性
get_property(myVAR TARGET a.out PROPERTY PNAME)

```

```cmake
add_executable(a.out main.c)
//设置属性
set_property(TARGET a.out PROPERTY SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
get_property(tmpVAR2 TARGET a.out PROPERTY SRC_DIR)
message(tmpVAR2 "value is ${tmpVAR2}")
```





## example 4

```cmake
get_property(
    is_multi_config_generator GLOBAL
    PROPERTY GENERATOR_IS_MULTI_CONFIG
)
```

这段代码是使用 `get_property` 命令从全局范围获取 `GENERATOR_IS_MULTI_CONFIG` 属性的值。

`GENERATOR_IS_MULTI_CONFIG` 是一个全局属性，它表示当前使用的 CMake 生成器是否支持多配置。如果当前的生成器支持多配置（例如 Visual Studio），那么这个属性的值将为 `TRUE`；否则，这个属性的值将为 `FALSE`。

在这段代码中，`is_multi_config_generator` 变量将被设置为 `GENERATOR_IS_MULTI_CONFIG` 属性的值。这样，你就可以在后续的 CMake 代码中使用 `is_multi_config_generator` 变量来判断当前的生成器是否支持多配置。





## example 5

设置目录的属性和取属性

```cmake
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY myName "no fucking name")
get_property(tmpVAR3 DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY myName)
message(tmpVAR3 "value is ${tmpVAR3}")
```



## example 6

自定义一个全局变量 并且取值

```cmake
# 设置全局属性
set_property(GLOBAL PROPERTY MY_GLOBAL_VAR "hello kitty")

# 获取全局属性
get_property(tempVar3 GLOBAL PROPERTY MY_GLOBAL_VAR)

# 检查属性值
if(tempVar3)
    message(STATUS "tempVar3 is true: tempVar3 =${tempVar3}")
else()
    message(STATUS "tempVar3 is false: tempVar3 =${tempVar3}")
endif()

```

