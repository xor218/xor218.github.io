---
layout: default
title: "cmake_dependent_option"
---
## cmake_dependent_option

 如何使用

GitHub Copilot: `cmake_dependent_option` 是一个 CMake 模块，它提供了一个创建依赖于其他选项的选项的方法。它的基本语法如下：

```cmake
cmake_dependent_option(<option_variable> "option description" <initial_value> <condition> <fallback_value>)
```

- `<option_variable>` 是你想要定义的变量的名称。
- `"option description"` 是对这个选项的描述，这个描述会在 CMake GUI 中显示。
- `<initial_value>` 是这个变量的初始值。
- `<condition>` 是一个条件表达式，只有当这个表达式为真时，`<option_variable>` 才会被设置为 `<initial_value>`，否则它会被设置为 `<fallback_value>`。

例如，假设你有一个选项 `USE_MY_LIB`，并且你想要创建一个新的选项 `USE_MY_LIB_ADVANCED_FEATURES`，但是这个新的选项只有在 `USE_MY_LIB` 为 `ON` 时才有效。你可以这样写：

```cmake
cmake_dependent_option(USE_MY_LIB_ADVANCED_FEATURES "Use advanced features of my library" ON "USE_MY_LIB" OFF)
```

这样，只有当 `USE_MY_LIB` 为 `ON` 时，`USE_MY_LIB_ADVANCED_FEATURES` 才会被设置为 `ON`，否则它会被设置为 `OFF`。





##  examples

‼️ 需要设置 i**nclude(CMakeDependentOption)**

```cmake
option(NEEDTEST "这是一个描述" ON)
include(CMakeDependentOption)
cmake_dependent_option(DEP_NEEDTEST "这也是一个描述" ON NEEDTEST ON)

if(DEP_NEEDTEST)
    message(ERROR "这是一个错误")
endif()
```

