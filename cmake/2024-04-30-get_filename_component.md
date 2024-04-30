---
layout: default
title: "get_filename_component 获取文件组件"
---
`get_filename_component` 函数在CMake中用于从路径中提取不同部分，如文件名、目录名等。它的一般语法如下：

```cmake
get_filename_component(<output_variable> <input> <component>)
```

- `<output_variable>`：用于存储提取的组件的变量名。
- `<input>`：要提取组件的路径或变量。
- `<component>`：要提取的组件类型，可以是以下之一：
  - `NAME`：文件或目录的名称（不包括路径和扩展名）。
  - `EXT`：文件的扩展名。
  - `NAME_WE`：文件的名称（不包括路径和扩展名）。
  - `DIR`：包含文件的目录。
  - `ABSOLUTE`：绝对路径。
  - 等等，还有其他可用的选项。

以下是一些示例用法：

```cmake
# 提取文件名
get_filename_component(filename "path/to/myfile.txt" NAME)
message("Filename: ${filename}")  # 输出 "Filename: myfile.txt"

# 提取目录名
get_filename_component(dirname "path/to/myfile.txt" DIRECTORY)
message("Directory: ${dirname}")  # 输出 "Directory: path/to"

# 提取文件扩展名
get_filename_component(extension "path/to/myfile.txt" EXT)
message("Extension: ${extension}")  # 输出 "Extension: .txt"

# 提取文件名称（不包括扩展名）
get_filename_component(name_without_extension "path/to/myfile.txt" NAME_WE)
message("Name without extension: ${name_without_extension}")  # 输出 "Name without extension: myfile"
```

这些示例演示了如何使用 `get_filename_component` 函数提取不同部分的路径信息。你可以根据你的需求使用其中的一个组件来处理路径或文件名。





## example 1 预编译文件

```cmake
#预编译
get_filename_component(SRC_FILE src/main.c ABSOLUTE)

# 设置预处理后的文件的路径
set(PREPROCESSED_FILE ${CMAKE_BINARY_DIR}/mainE.c)


# 添加一个自定义命令来预处理源文件
add_custom_command(
    OUTPUT ${PREPROCESSED_FILE}
    COMMAND gcc -E -P ${SRC_FILE} -o ${PREPROCESSED_FILE}
    DEPENDS ${SRC_FILE}
    COMMENT "Preprocessing ${SRC_FILE}"

    # VERBATIM
)

# 添加一个自定义目标来运行预处理命令
add_custom_target(preprocess DEPENDS ${PREPROCESSED_FILE})
```

