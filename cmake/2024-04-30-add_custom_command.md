---
layout: default
title: "add_custom_command"
---
```cmake
cmake_minimum_required(VERSION 3.12)

project(main LANGUAGES CXX)


add_executable(${PROJECT_NAME} main.cpp)
```



```cmake
# 添加普通命令
add_custom_command(
    OUTPUT "${CMAKE_BINARY_DIR}/EPmain.cpp"
    COMMAND g++ -E -P "${CMAKE_SOURCE_DIR}/main.cpp" -o "${CMAKE_BINARY_DIR}/EPmain.cpp"
    DEPENDS "${CMAKE_SOURCE_DIR}/main.cpp"
)
```



```cmake
# 添加普通目标
add_custom_target(
    finish  
    DEPENDS "${CMAKE_BINARY_DIR}/EPmain.cpp"
)
```

