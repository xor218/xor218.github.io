---
layout: default
title: "link library 链接库"
---

```cmake


set(includedir "/usr/local/opt/mysql-client/include")

set(libDir "/usr/local/opt/mysql-client/lib ")

set(libName "mysqlclient")

set(CMAKE_EXPORT_COMPILE_COMMANDS true)

cmake_minimum_required(VERSION 3.15)

project(sql.out)

add_executable(${PROJECT_NAME} sql.c)

include_directories(${includedir})

link_directories(${libDir})

target_link_libraries(${PROJECT_NAME} ${libName})
```