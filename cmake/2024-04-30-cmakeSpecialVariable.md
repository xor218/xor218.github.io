---
layout: default
title: "cmake中的特殊变量"
---
## cmake 为每个不同的操作系统定义好了一些不同的宏

**系统信息宏**

- **CMAKE_SYSTEM_NAME**：系统名称，例如 Linux、Windows、macOS。
- **CMAKE_SYSTEM_VERSION**：系统版本。
- **CMAKE_SYSTEM_PROCESSOR**：系统处理器架构。

**编译器信息宏**

- **CMAKE_C_COMPILER_ID**：C 编译器的编译器 ID。
- **CMAKE_CXX_COMPILER_ID**：C++ 编译器的编译器 ID。 **Intel** ，**Clang**，**GNU**

**其他宏**

- **CMAKE_BUILD_TYPE**：构建类型，例如 Debug、Release、RelWithDebInfo。
- **CMAKE_MODULE_PATH**：CMake 模块的搜索路径。
- **CMAKE_INSTALL_PREFIX**：安装路径。
- **CMAKE_SIZEOF_VOID_P**:指针大小 8 或者4

**以下是一些常用的宏的详细说明：**

**CMAKE_SYSTEM_NAME**

- CMAKE_SYSTEM_NAME 宏的值取决于当前系统的名称。例如，在 Linux 系统上，CMAKE_SYSTEM_NAME 的值为 "Linux"。在 Windows 系统上，CMAKE_SYSTEM_NAME 的值为 "Windows"。

**CMAKE_SYSTEM_VERSION**

- CMAKE_SYSTEM_VERSION 宏的值取决于当前系统的版本。例如，在 Linux 系统上，CMAKE_SYSTEM_VERSION 的值为 "5.10.0-22-generic"。在 Windows 系统上，CMAKE_SYSTEM_VERSION 的值为 "10.0.19043.1348"。

**CMAKE_SYSTEM_PROCESSOR**

- CMAKE_SYSTEM_PROCESSOR 宏的值取决于当前系统的处理器架构。例如，在 x86 系统上，CMAKE_SYSTEM_PROCESSOR 的值为 "x86_64"。在 ARM 系统上，CMAKE_SYSTEM_PROCESSOR 的值为 "arm64"。

**CMAKE_C_COMPILER_ID**

- CMAKE_C_COMPILER_ID 宏的值取决于当前使用的 C 编译器的编译器 ID。例如，在使用 GCC 编译器的 Linux 系统上，- 
- CMAKE_C_COMPILER_ID 的值为 "GNU"。在使用 Visual Studio 编译器的 Windows 系统上，CMAKE_C_COMPILER_ID 的值为 "MSVC"。

**CMAKE_CXX_COMPILER_ID**

- CMAKE_CXX_COMPILER_ID 宏的值取决于当前使用的 C++ 编译器的编译器 ID。例如，在使用 GCC 编译器的 Linux 系统上- 
- CMAKE_CXX_COMPILER_ID 的值为 "GNU"。在使用 Visual Studio 编译器的 Windows 系统上，CMAKE_CXX_COMPILER_ID 的值为 "MSVC"。

**CMAKE_BUILD_TYPE**

- CMAKE_BUILD_TYPE 宏的值取决于当前的构建类型。构建类型可以设置为 Debug、Release、RelWithDebInfo 或 MinSizeRel。

**CMAKE_MODULE_PATH**

- CMAKE_MODULE_PATH 宏的值指定了 CMake 模块的搜索路径。CMake 模块是 CMake 的扩展，可以用于在构建系统中执行各种任务。

**CMAKE_INSTALL_PREFIX**

- CMAKE_INSTALL_PREFIX 宏的值指定了安装路径。安装路径是安装软件包的目标目录。







## cmake 特殊变量

`CMAKE_SYSTEM_NAME`  检测系统名称 Darwin(macos),Linux/linux,Windows,or AIX/IBM




CMake 是一个用于管理项目构建过程的工具，它确实有一些特殊的默认变量和预定义变量，用于控制构建过程和配置项目。以下是一些常见的 CMake 默认变量和预定义变量：

1. `CMAKE_SOURCE_DIR`：表示顶级源代码目录的路径。
2. `CMAKE_BINARY_DIR`：表示顶级构建目录的路径。
3. `CMAKE_CURRENT_SOURCE_DIR`：表示当前处理的 CMakeLists.txt 文件所在的目录。
4. `CMAKE_CURRENT_BINARY_DIR`：表示当前处理的 CMakeLists.txt 文件的构建目录。
5. `CMAKE_INSTALL_PREFIX`：表示项目安装的根目录。可以使用 `-DCMAKE_INSTALL_PREFIX=<path>` 来自定义此变量的值。
6. `CMAKE_C_COMPILER` 和 `CMAKE_CXX_COMPILER`：表示 C 和 C++ 编译器的路径。可以使用 `-DCMAKE_C_COMPILER=<compiler>` 和 `-DCMAKE_CXX_COMPILER=<compiler>` 来指定特定的编译器。
7. `CMAKE_BUILD_TYPE`：表示构建类型，如 Debug、Release、RelWithDebInfo 等。可以使用 `-DCMAKE_BUILD_TYPE=<type>` 来设置构建类型。
8. `CMAKE_SYSTEM_NAME`：表示目标操作系统的名称。
9. `CMAKE_SYSTEM_VERSION`：表示目标操作系统的版本。
10. `CMAKE_SYSTEM_PROCESSOR`：表示目标处理器的架构。
11. `CMAKE_MODULE_PATH`：包含 CMake 模块文件的路径列表，用于自定义 CMake 行为。
12. `CMAKE_PREFIX_PATH`：包含要搜索的附加安装目录的路径列表，用于查找依赖项。
13. `CMAKE_FIND_ROOT_PATH`：设置用于在交叉编译环境中查找库和头文件的根路径。
14. `CMAKE_BUILD_TOOL`：表示构建项目所使用的构建工具，默认情况下为空。

这些变量可以用于 CMakeLists.txt 文件中，以自定义项目的构建和配置过程。在编写 CMake 脚本时，您可以使用这些变量来决定项目的构建选项、依赖项和安装路径等。

请注意，这些变量只是 CMake 的一部分，您还可以在自己的 CMakeLists.txt 文件中定义和使用自定义变量，以满足特定项目的需求。如果需要查看所有 CMake 预定义变量的完整列表，可以查阅 CMake 官方文档或运行 `cmake --help-variable-list` 命令。

```cmake


project(ProjectName)

message(STATUS "顶级源代码目录的路径:CMAKE_SOURCE_DIR >>> "${CMAKE_SOURCE_DIR})


message(STATUS "表示顶级构建目录的路径>>>>>> " ${CMAKE_BINARY_DIR})
message(STATUS "表示当前处理的 CMakeLists.txt 文件所在的目录       >>>>>> " ${CMAKE_CURRENT_SOURCE_DIR})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的构建目录       >>>>>> " ${CMAKE_CURRENT_BINARY_DIR})
message(STATUS "表示项目安装的根目录。                            >>>>>> " ${CMAKE_INSTALL_PREFIX})
message(STATUS "表示 C 编译器的路径                              >>>>>> " ${CMAKE_C_COMPILER})
message(STATUS "表示 C++ 编译器的路径                             >>>>>> " ${CMAKE_CXX_COMPILER})
message(STATUS "表示构建类型，如 Debug、Release、RelWithDebInfo    >>>>>> " ${CMAKE_BUILD_TYPE})
message(STATUS "表示目标操作系统的名称                              >>>>>> " ${CMAKE_SYSTEM_NAME})
message(STATUS "表示目标操作系统的版本                              >>>>>> " ${CMAKE_SYSTEM_VERSION})
message(STATUS "表示目标处理器的架构。                              >>>>>> " ${CMAKE_SYSTEM_PROCESSOR})
message(STATUS "包含 CMake 模块文件的路径列表，用于自定义 CMake 行为。 >>>>>> " ${CMAKE_MODULE_PATH})
message(STATUS "包含要搜索的附加安装目录的路径列表，用于查找依赖项       >>>>>> " ${CMAKE_PREFIX_PATH})
message(STATUS "设置用于在交叉编译环境中查找库和头文件的根路径。         >>>>>> " ${CMAKE_FIND_ROOT_PATH})
message(STATUS "表示构建项目所使用的构建工具，默认情况下为空。          >>>>>> " ${CMAKE_BUILD_TOOL})


message(STATUS "表示构建目标文件所在的目录: CMAKE_BINARY_DIR >>>" ${CMAKE_BINARY_DIR})


message(STATUS "表示项目的源代码根目录: CMAKE_SOURCE_DIR >>> ${CMAKE_SOURCE_DIR}")
message(STATUS "表示项目生成的可执行文件的输出目录: CMAKE_RUNTIME_OUTPUT_DIRECTORY >>> ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
message(STATUS "表示项目生成的库文件的输出目录: CMAKE_LIBRARY_OUTPUT_DIRECTORY >>> ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
message(STATUS "表示项目生成的归档文件（静态库）的输出目录: CMAKE_ARCHIVE_OUTPUT_DIRECTORY >>> ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")
message(STATUS "表示构建目标平台的操作系统: CMAKE_SYSTEM >>> ${CMAKE_SYSTEM}")
message(STATUS "表示 CMake 的版本号: CMAKE_VERSION >>> ${CMAKE_VERSION}")
message(STATUS "表示 CMake 的生成器: CMAKE_GENERATOR >>> ${CMAKE_GENERATOR}")
message(STATUS "表示 CMake 的生成器平台: CMAKE_GENERATOR_PLATFORM >>> ${CMAKE_GENERATOR_PLATFORM}")
message(STATUS "表示 CMake 的生成器工具: CMAKE_GENERATOR_TOOLSET >>> ${CMAKE_GENERATOR_TOOLSET}")
message(STATUS "表示 CMake 的构建类型列表: CMAKE_CONFIGURATION_TYPES >>> ${CMAKE_CONFIGURATION_TYPES}")



message(STATUS "表示项目的主要 CMakeLists.txt 文件所在的目录: CMAKE_CURRENT_LIST_DIR >>> ${CMAKE_CURRENT_LIST_DIR}")
message(STATUS "表示当前处理的 CMakeLists.txt 文件的相对路径: CMAKE_CURRENT_LIST_FILE >>> ${CMAKE_CURRENT_LIST_FILE}")
message(STATUS "表示当前处理的 CMakeLists.txt 文件的文件名: CMAKE_CURRENT_LIST_FILE_NAME >>> ${CMAKE_CURRENT_LIST_FILE_NAME}")
message(STATUS "表示项目的根目录: CMAKE_PROJECT_DIR >>> ${CMAKE_PROJECT_DIR}")
message(STATUS "表示项目的构建系统名称: CMAKE_BUILD_SYSTEM >>> ${CMAKE_BUILD_SYSTEM}")
message(STATUS "表示 CMake 的构建目标名称: CMAKE_BUILD_NAME >>> ${CMAKE_BUILD_NAME}")
message(STATUS "表示 CMake 编译器标志: CMAKE_CXX_FLAGS >>> ${CMAKE_CXX_FLAGS}")
message(STATUS "表示 CMake C 标志: CMAKE_C_FLAGS >>> ${CMAKE_C_FLAGS}")
message(STATUS "表示 CMake 连接器标志: CMAKE_EXE_LINKER_FLAGS >>> ${CMAKE_EXE_LINKER_FLAGS}")
message(STATUS "表示 CMake 共享库链接标志: CMAKE_SHARED_LINKER_FLAGS >>> ${CMAKE_SHARED_LINKER_FLAGS}")


message(STATUS "表示构建系统信息: CMAKE_SYSTEM_INFO_FILE >>> ${CMAKE_SYSTEM_INFO_FILE}")
message(STATUS "表示 CMake 缓存文件的路径: CMAKE_CACHEFILE_DIR >>> ${CMAKE_CACHEFILE_DIR}")
message(STATUS "表示构建项目所使用的 CMake 安装目录: CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT >>> ${CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT}")
message(STATUS "表示 CMake 构建目录中临时文件的目录: CMAKE_BINARY_DIR_T >>> ${CMAKE_BINARY_DIR_T}")
message(STATUS "表示 CMake 源代码目录中临时文件的目录: CMAKE_CURRENT_BINARY_DIR_T >>> ${CMAKE_CURRENT_BINARY_DIR_T}")
message(STATUS "表示项目的名称: CMAKE_PROJECT_NAME >>> ${CMAKE_PROJECT_NAME}")
message(STATUS "表示 CMake 的主机系统名称: CMAKE_HOST_SYSTEM_NAME >>> ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "表示 CMake 的主机系统版本: CMAKE_HOST_SYSTEM_VERSION >>> ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "表示 CMake 的主机系统处理器架构: CMAKE_HOST_SYSTEM_PROCESSOR >>> ${CMAKE_HOST_SYSTEM_PROCESSOR}")



message(STATUS "表示构建目标的名称: CMAKE_PROJECT_VERSION >>> ${CMAKE_PROJECT_VERSION}")
message(STATUS "表示构建目标的修订版本: CMAKE_PROJECT_VERSION_PATCH >>> ${CMAKE_PROJECT_VERSION_PATCH}")
message(STATUS "表示 CMakeLists.txt 文件的相对路径: CMAKE_CURRENT_LIST_DIR >>> ${CMAKE_CURRENT_LIST_DIR}")
message(STATUS "表示当前处理的 CMakeLists.txt 文件的完整路径: CMAKE_CURRENT_LIST_FILE >>> ${CMAKE_CURRENT_LIST_FILE}")
message(STATUS "表示当前处理的 CMakeLists.txt 文件的文件名: CMAKE_CURRENT_LIST_FILE_NAME >>> ${CMAKE_CURRENT_LIST_FILE_NAME}")
message(STATUS "表示 CMake 编译器的标志: CMAKE_CXX_FLAGS >>> ${CMAKE_CXX_FLAGS}")
message(STATUS "表示 CMake C 编译器的标志: CMAKE_C_FLAGS >>> ${CMAKE_C_FLAGS}")
message(STATUS "表示 CMake 连接器的标志: CMAKE_EXE_LINKER_FLAGS >>> ${CMAKE_EXE_LINKER_FLAGS}")
message(STATUS "表示 CMake 共享库链接标志: CMAKE_SHARED_LINKER_FLAGS >>> ${CMAKE_SHARED_LINKER_FLAGS}")
message(STATUS "表示 CMake 静态库链接标志: CMAKE_STATIC_LINKER_FLAGS >>> ${CMAKE_STATIC_LINKER_FLAGS}")
message(STATUS "表示 CMake 链接器的额外标志: CMAKE_LINKER_FLAGS >>> ${CMAKE_LINKER_FLAGS}")

message(STATUS "表示源文件的扩展名: CMAKE_SOURCE_DIR_EXT >>> ${CMAKE_SOURCE_DIR_EXT}")
message(STATUS "表示构建文件的扩展名: CMAKE_BINARY_DIR_EXT >>> ${CMAKE_BINARY_DIR_EXT}")
message(STATUS "表示当前处理的 CMakeLists.txt 文件的扩展名: CMAKE_CURRENT_SOURCE_DIR_EXT >>> ${CMAKE_CURRENT_SOURCE_DIR_EXT}")
message(STATUS "表示当前处理的 CMakeLists.txt 文件的构建目录的扩展名: CMAKE_CURRENT_BINARY_DIR_EXT >>> ${CMAKE_CURRENT_BINARY_DIR_EXT}")
message(STATUS "表示项目安装的根目录的扩展名: CMAKE_INSTALL_PREFIX_EXT >>> ${CMAKE_INSTALL_PREFIX_EXT}")
message(STATUS "表示 C 编译器的路径的扩展名: CMAKE_C_COMPILER_EXT >>> ${CMAKE_C_COMPILER_EXT}")
message(STATUS "表示 C++ 编译器的路径的扩展名: CMAKE_CXX_COMPILER_EXT >>> ${CMAKE_CXX_COMPILER_EXT}")
message(STATUS "表示构建类型的扩展名，如 Debug、Release、RelWithDebInfo: CMAKE_BUILD_TYPE_EXT >>> ${CMAKE_BUILD_TYPE_EXT}")
message(STATUS "表示目标操作系统的名称的扩展名: CMAKE_SYSTEM_NAME_EXT >>> ${CMAKE_SYSTEM_NAME_EXT}")
message(STATUS "表示目标操作系统的版本的扩展名: CMAKE_SYSTEM_VERSION_EXT >>> ${CMAKE_SYSTEM_VERSION_EXT}")
message(STATUS "表示目标处理器的架构的扩展名: CMAKE_SYSTEM_PROCESSOR_EXT >>> ${CMAKE_SYSTEM_PROCESSOR_EXT}")


message(STATUS "表示 CMake 的主机系统版本: CMAKE_HOST_SYSTEM_VERSION >>> ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "表示 CMake 的主机系统处理器架构: CMAKE_HOST_SYSTEM_PROCESSOR >>> ${CMAKE_HOST_SYSTEM_PROCESSOR}")
message(STATUS "表示 CMake 的系统信息文件路径: CMAKE_SYSTEM_INFO_FILE >>> ${CMAKE_SYSTEM_INFO_FILE}")
message(STATUS "表示 CMake 的构建目标平台名称: CMAKE_BUILD_SYSTEM >>> ${CMAKE_BUILD_SYSTEM}")
message(STATUS "表示 CMake 的构建目标名称: CMAKE_BUILD_NAME >>> ${CMAKE_BUILD_NAME}")
message(STATUS "表示 CMake 缓存文件路径: CMAKE_CACHEFILE_DIR >>> ${CMAKE_CACHEFILE_DIR}")
message(STATUS "表示 CMake 的生成器目标类型: CMAKE_GENERATOR_TARGET_TYPE >>> ${CMAKE_GENERATOR_TARGET_TYPE}")
message(STATUS "表示 CMake 的生成器工具链文件: CMAKE_GENERATOR_TOOLCHAIN >>> ${CMAKE_GENERATOR_TOOLCHAIN}")
message(STATUS "表示 CMake 构建目录中的临时文件目录: CMAKE_BINARY_DIR_T >>> ${CMAKE_BINARY_DIR_T}")
message(STATUS "表示 CMake 源代码目录中的临时文件目录: CMAKE_CURRENT_BINARY_DIR_T >>> ${CMAKE_CURRENT_BINARY_DIR_T}")
message(STATUS "表示 CMake 的项目名称: CMAKE_PROJECT_NAME >>> ${CMAKE_PROJECT_NAME}")
message(STATUS "表示 CMake 的项目版本: CMAKE_PROJECT_VERSION >>> ${CMAKE_PROJECT_VERSION}")

message(STATUS "表示项目的源代码根目录: CMAKE_SOURCE_DIR >>>" ${CMAKE_SOURCE_DIR})
message(STATUS "表示项目生成的可执行文件的输出目录: CMAKE_RUNTIME_OUTPUT_DIRECTORY >>>" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
message(STATUS "表示项目生成的库文件的输出目录: CMAKE_LIBRARY_OUTPUT_DIRECTORY >>>" ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
message(STATUS "表示项目生成的归档文件（静态库）的输出目录: CMAKE_ARCHIVE_OUTPUT_DIRECTORY >>>" ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
message(STATUS "表示构建目标平台的操作系统: CMAKE_SYSTEM >>>" ${CMAKE_SYSTEM})
message(STATUS "表示 CMake 的版本号: CMAKE_VERSION >>>" ${CMAKE_VERSION})
message(STATUS "表示 CMake 的生成器: CMAKE_GENERATOR >>>" ${CMAKE_GENERATOR})
message(STATUS "表示 CMake 的生成器平台: CMAKE_GENERATOR_PLATFORM >>>" ${CMAKE_GENERATOR_PLATFORM})
message(STATUS "表示 CMake 的生成器工具: CMAKE_GENERATOR_TOOLSET >>>" ${CMAKE_GENERATOR_TOOLSET})
message(STATUS "表示 CMake 的构建类型列表: CMAKE_CONFIGURATION_TYPES >>>" ${CMAKE_CONFIGURATION_TYPES})



message(STATUS "表示项目的主要 CMakeLists.txt 文件所在的目录: CMAKE_CURRENT_LIST_DIR >>>" ${CMAKE_CURRENT_LIST_DIR})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的相对路径: CMAKE_CURRENT_LIST_FILE >>>" ${CMAKE_CURRENT_LIST_FILE})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的文件名: CMAKE_CURRENT_LIST_FILE_NAME >>>" ${CMAKE_CURRENT_LIST_FILE_NAME})
message(STATUS "表示项目的根目录: CMAKE_PROJECT_DIR >>>" ${CMAKE_PROJECT_DIR})
message(STATUS "表示项目的构建系统名称: CMAKE_BUILD_SYSTEM >>>" ${CMAKE_BUILD_SYSTEM})
message(STATUS "表示 CMake 的构建目标名称: CMAKE_BUILD_NAME >>>" ${CMAKE_BUILD_NAME})
message(STATUS "表示 CMake 编译器标志: CMAKE_CXX_FLAGS >>>" ${CMAKE_CXX_FLAGS})
message(STATUS "表示 CMake C 标志: CMAKE_C_FLAGS >>>" ${CMAKE_C_FLAGS})
message(STATUS "表示 CMake 连接器标志: CMAKE_EXE_LINKER_FLAGS >>>" ${CMAKE_EXE_LINKER_FLAGS})
message(STATUS "表示 CMake 共享库链接标志: CMAKE_SHARED_LINKER_FLAGS >>>" ${CMAKE_SHARED_LINKER_FLAGS})


message(STATUS "表示构建系统信息: CMAKE_SYSTEM_INFO_FILE >>>" ${CMAKE_SYSTEM_INFO_FILE})
message(STATUS "表示 CMake 缓存文件的路径: CMAKE_CACHEFILE_DIR >>>" ${CMAKE_CACHEFILE_DIR})
message(STATUS "表示构建项目所使用的 CMake 安装目录: CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT >>>" ${CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT})
message(STATUS "表示 CMake 构建目录中临时文件的目录: CMAKE_BINARY_DIR_T >>>" ${CMAKE_BINARY_DIR_T})
message(STATUS "表示 CMake 源代码目录中临时文件的目录: CMAKE_CURRENT_BINARY_DIR_T >>>" ${CMAKE_CURRENT_BINARY_DIR_T})
message(STATUS "表示项目的名称: CMAKE_PROJECT_NAME >>>" ${CMAKE_PROJECT_NAME})
message(STATUS "表示 CMake 的主机系统名称: CMAKE_HOST_SYSTEM_NAME >>>" ${CMAKE_HOST_SYSTEM_NAME})
message(STATUS "表示 CMake 的主机系统版本: CMAKE_HOST_SYSTEM_VERSION >>>" ${CMAKE_HOST_SYSTEM_VERSION})
message(STATUS "表示 CMake 的主机系统处理器架构: CMAKE_HOST_SYSTEM_PROCESSOR >>>" ${CMAKE_HOST_SYSTEM_PROCESSOR})



message(STATUS "表示构建目标的名称: CMAKE_PROJECT_VERSION >>>" ${CMAKE_PROJECT_VERSION})
message(STATUS "表示构建目标的修订版本: CMAKE_PROJECT_VERSION_PATCH >>>" ${CMAKE_PROJECT_VERSION_PATCH})
message(STATUS "表示 CMakeLists.txt 文件的相对路径: CMAKE_CURRENT_LIST_DIR >>>" ${CMAKE_CURRENT_LIST_DIR})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的完整路径: CMAKE_CURRENT_LIST_FILE >>>" ${CMAKE_CURRENT_LIST_FILE})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的文件名: CMAKE_CURRENT_LIST_FILE_NAME >>>" ${CMAKE_CURRENT_LIST_FILE_NAME})
message(STATUS "表示 CMake 编译器的标志: CMAKE_CXX_FLAGS >>>" ${CMAKE_CXX_FLAGS})
message(STATUS "表示 CMake C 编译器的标志: CMAKE_C_FLAGS >>>" ${CMAKE_C_FLAGS})
message(STATUS "表示 CMake 连接器的标志: CMAKE_EXE_LINKER_FLAGS >>>" ${CMAKE_EXE_LINKER_FLAGS})
message(STATUS "表示 CMake 共享库链接标志: CMAKE_SHARED_LINKER_FLAGS >>>" ${CMAKE_SHARED_LINKER_FLAGS})
message(STATUS "表示 CMake 静态库链接标志: CMAKE_STATIC_LINKER_FLAGS >>>" ${CMAKE_STATIC_LINKER_FLAGS})
message(STATUS "表示 CMake 链接器的额外标志: CMAKE_LINKER_FLAGS >>>" ${CMAKE_LINKER_FLAGS})

message(STATUS "表示源文件的扩展名: CMAKE_SOURCE_DIR_EXT >>>" ${CMAKE_SOURCE_DIR_EXT})
message(STATUS "表示构建文件的扩展名: CMAKE_BINARY_DIR_EXT >>>" ${CMAKE_BINARY_DIR_EXT})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的扩展名: CMAKE_CURRENT_SOURCE_DIR_EXT >>>" ${CMAKE_CURRENT_SOURCE_DIR_EXT})
message(STATUS "表示当前处理的 CMakeLists.txt 文件的构建目录的扩展名: CMAKE_CURRENT_BINARY_DIR_EXT >>>" ${CMAKE_CURRENT_BINARY_DIR_EXT})
message(STATUS "表示项目安装的根目录的扩展名: CMAKE_INSTALL_PREFIX_EXT >>>" ${CMAKE_INSTALL_PREFIX_EXT})
message(STATUS "表示 C 编译器的路径的扩展名: CMAKE_C_COMPILER_EXT >>>" ${CMAKE_C_COMPILER_EXT})
message(STATUS "表示 C++ 编译器的路径的扩展名: CMAKE_CXX_COMPILER_EXT >>>" ${CMAKE_CXX_COMPILER_EXT})
message(STATUS "表示构建类型的扩展名，如 Debug、Release、RelWithDebInfo: CMAKE_BUILD_TYPE_EXT >>>" ${CMAKE_BUILD_TYPE_EXT})
message(STATUS "表示目标操作系统的名称的扩展名: CMAKE_SYSTEM_NAME_EXT >>>" ${CMAKE_SYSTEM_NAME_EXT})
message(STATUS "表示目标操作系统的版本的扩展名: CMAKE_SYSTEM_VERSION_EXT >>>" ${CMAKE_SYSTEM_VERSION_EXT})
message(STATUS "表示目标处理器的架构的扩展名: CMAKE_SYSTEM_PROCESSOR_EXT >>>" ${CMAKE_SYSTEM_PROCESSOR_EXT})


message(STATUS "表示 CMake 的主机系统版本: CMAKE_HOST_SYSTEM_VERSION >>>" ${CMAKE_HOST_SYSTEM_VERSION})
message(STATUS "表示 CMake 的主机系统处理器架构: CMAKE_HOST_SYSTEM_PROCESSOR >>>" ${CMAKE_HOST_SYSTEM_PROCESSOR})
message(STATUS "表示 CMake 的系统信息文件路径: CMAKE_SYSTEM_INFO_FILE >>>" ${CMAKE_SYSTEM_INFO_FILE})
message(STATUS "表示 CMake 的构建目标平台名称: CMAKE_BUILD_SYSTEM >>>" ${CMAKE_BUILD_SYSTEM})
message(STATUS "表示 CMake 的构建目标名称: CMAKE_BUILD_NAME >>>" ${CMAKE_BUILD_NAME})
message(STATUS "表示 CMake 缓存文件路径: CMAKE_CACHEFILE_DIR >>>" ${CMAKE_CACHEFILE_DIR})
message(STATUS "表示 CMake 的生成器目标类型: CMAKE_GENERATOR_TARGET_TYPE >>>" ${CMAKE_GENERATOR_TARGET_TYPE})
message(STATUS "表示 CMake 的生成器工具链文件: CMAKE_GENERATOR_TOOLCHAIN >>>" ${CMAKE_GENERATOR_TOOLCHAIN})
message(STATUS "表示 CMake 构建目录中的临时文件目录: CMAKE_BINARY_DIR_T >>>" ${CMAKE_BINARY_DIR_T})
message(STATUS "表示 CMake 源代码目录中的临时文件目录: CMAKE_CURRENT_BINARY_DIR_T >>>" ${CMAKE_CURRENT_BINARY_DIR_T})
message(STATUS "表示 CMake 的项目名称: CMAKE_PROJECT_NAME >>>" ${CMAKE_PROJECT_NAME})
message(STATUS "表示 CMake 的项目版本: CMAKE_PROJECT_VERSION >>>" ${CMAKE_PROJECT_VERSION})



```
