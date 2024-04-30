---
layout: default
title: "list Append"
---
在 CMake 中，您可以使用 `list(APPEND ...)` 命令来创建和管理列表。对于您的情况，如果您需要添加多个头文件路径到预处理命令中，您可以先创建一个包含所有路径的列表，然后将该列表用于构建您的命令。

以下是如何在 CMake 中使用列表来组织和使用头文件路径的示例：

1. **创建和填充头文件路径列表**：

```cmake
# 创建一个空的列表
set(INCLUDE_PATHS "")

# 向列表中添加路径
list(APPEND INCLUDE_PATHS "path/to/your/include1")
list(APPEND INCLUDE_PATHS "path/to/your/include2")
# ... 添加更多路径
```

2. **将列表转换为编译器参数**：

接下来，您需要将这个列表转换为适合编译器的 `-I` 参数格式。这可以通过 `foreach` 循环来实现：

```cmake
# 初始化一个包含预处理器参数的字符串
set(PREPROCESSOR_ARGS "")

# 遍历路径列表并追加到参数字符串
foreach(INCLUDE_PATH ${INCLUDE_PATHS})
    list(APPEND PREPROCESSOR_ARGS "-I${INCLUDE_PATH}")
endforeach()
```

3. **在 `add_custom_command` 中使用这些参数**：

现在您可以使用这些预处理器参数来构建您的预处理命令：

```cmake
add_custom_command(
    OUTPUT "${CMAKE_BINARY_DIR}/E_P_picow_blink.c"
    COMMAND ${CMAKE_C_COMPILER} -E -P ${PREPROCESSOR_ARGS} "/Users/min122218/GitHub/PicoW_Objs/tmp/picow_blink.c" -o "${CMAKE_BINARY_DIR}/E_P_picow_blink.c"
    DEPENDS "/Users/min122218/GitHub/PicoW_Objs/tmp/picow_blink.c"
)
```

在这个示例中，`${PREPROCESSOR_ARGS}` 将展开为您之前添加到列表中的每个 `-I` 路径。确保替换路径为您实际需要包含的头文件路径。这种方法使得管理和修改路径变得更加灵活和清晰。
