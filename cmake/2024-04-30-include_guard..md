---
layout: default
title: "include_guard"
---

## 语法



在 CMake 中，`include_guard()` 函数用于防止文件被多次包含。它类似于 C/C++ 语言中的头文件保护（#ifndef/#define/#endif），用于防止因文件被重复包含而导致的重复定义问题。

当你在一个 CMake 文件中使用 `include_guard(GLOBAL)` 时，它会确保该文件在整个项目中只被评估（或包含）一次，即使该文件在多个地方被 `include` 也是如此。

- `GLOBAL` 关键字指示这个保护应该在全局范围内应用。这意味着一旦这个文件被包含并执行了一次，它就不会在项目的其他任何地方再次被执行。

这在管理大型项目中非常有用，特别是当你有多个 CMake 文件可能会互相包含，或者一个文件可能会在不同的地方被多次包含时。使用 `include_guard(GLOBAL)` 可以确保相关的配置、宏定义或其他设置只被执行一次，避免潜在的冲突和重复设置问题。

例如：

```cmake
# MyUtilities.cmake
include_guard(GLOBAL)

# 设置或定义一些变量、函数等
```

当其他 CMake 文件使用 `include(MyUtilities.cmake)` 时，`MyUtilities.cmake` 中的内容只会在第一次被包含时执行。后续的 `include` 调用将会被忽略，确保了代码的唯一性执行。