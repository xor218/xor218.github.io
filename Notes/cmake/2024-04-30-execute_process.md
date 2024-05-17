---
layout: default
title: "*execute_process "
---
**execute_process 会直接执行命令**




## 语法

在 CMake 中，`execute_process` 命令用于在配置阶段同步执行一个子进程，并且可以获取该子进程的输出。这个命令非常强大，允许你运行外部程序并处理它们的输出。`execute_process` 的基本语法如下：

```cmake
execute_process(COMMAND <cmd1> [args1...]
                [COMMAND <cmd2> [args2...] ...]
                [WORKING_DIRECTORY <dir>]
                [TIMEOUT <seconds>]
                [RESULT_VARIABLE <var>]
                [OUTPUT_VARIABLE <var>]
                [ERROR_VARIABLE <var>]
                [INPUT_FILE <file>]
                [OUTPUT_FILE <file>]
                [ERROR_FILE <file>]
                [OUTPUT_QUIET]
                [ERROR_QUIET]
                [OUTPUT_STRIP_TRAILING_WHITESPACE]
                [ERROR_STRIP_TRAILING_WHITESPACE]
                [ECHO_OUTPUT_VARIABLE]
                [ECHO_ERROR_VARIABLE])
```

- `COMMAND <cmd> [args...]`: 指定要运行的命令及其参数。可以指定多个 `COMMAND`，它们将按顺序执行。

- `WORKING_DIRECTORY <dir>`: 设置命令的工作目录。

- `TIMEOUT <seconds>`: 指定命令执行的最长时间。如果指定的时间过去后命令仍在运行，它将被终止。

- `RESULT_VARIABLE <var>`: 将命令的退出代码存储在变量 `<var>` 中。

- `OUTPUT_VARIABLE <var>` 和 `ERROR_VARIABLE <var>`: 分别将命令的标准输出和标准错误输出存储在指定的变量中。

- `INPUT_FILE <file>`, `OUTPUT_FILE <file>`, `ERROR_FILE <file>`: 分别指定命令的标准输入、输出和错误输出应该重定向到的文件。

- `OUTPUT_QUIET` 和 `ERROR_QUIET`: 抑制标准输出或标准错误输出的打印。

- `OUTPUT_STRIP_TRAILING_WHITESPACE` 和 `ERROR_STRIP_TRAILING_WHITESPACE`: 删除输出和错误输出中的尾随空白。

- `ECHO_OUTPUT_VARIABLE` 和 `ECHO_ERROR_VARIABLE`: 打印输出或错误变量的内容。

这个命令通常用于运行一些构建过程中需要的外部命令，比如脚本、编译工具等。例如：

```cmake
execute_process(COMMAND ls -la
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                RESULT_VARIABLE ls_result
                OUTPUT_VARIABLE ls_output)
```

这会在 CMake 源目录中执行 `ls -la` 命令，并将输出结果存储在 `ls_output` 变量中，命令执行的结果代码存储在 `ls_result` 变量中。





## 区别

是的，`execute_process` 命令在 CMake 配置阶段会直接执行指定的命令。这是它与 `add_custom_command` 或 `add_custom_target` 的主要区别之一。`execute_process` 用于在 CMake 处理其 CMakeLists.txt 文件时立即执行命令，而 `add_custom_command` 和 `add_custom_target` 则定义了在构建阶段执行的命令。

使用 `execute_process` 的关键点是：

1. **同步执行**：它会阻塞 CMake 进程，直到指定的命令完成执行。这意味着后续的 CMake 指令会等待这个命令执行完毕后再继续。

2. **配置阶段执行**：它在 CMake 的配置阶段执行，即在生成构建系统之前。这通常用于预先检查环境、生成配置文件、执行必要的预处理步骤等。

3. **直接处理结果**：你可以直接获取命令的输出、错误输出和退出代码，这对于根据外部命令的结果调整构建过程非常有用。

例如，如果你想在配置时检查某个工具的版本或检查某个外部依赖是否存在，你可以使用 `execute_process`。但要注意，过度使用 `execute_process` 可能会使 CMake 配置过程变慢，并且可能导致跨平台兼容性问题，因为执行的命令可能在不同的系统上表现不同。