---
layout: default
title: "find_package"
---
## find_package 如何找到包的路径
**实际上，find_package 命令在查找包时，会首先在 CMAKE_PREFIX_PATH、CMAKE_FRAMEWORK_PATH 和 CMAKE_APPBUNDLE_PATH 中查找。如果在这些路径中没有找到，它会继续在 CMAKE_SYSTEM_PREFIX_PATH 中查找。**





## find_package  

`find_package` 是CMake中的一个命令，用于在CMake项目中查找和导入外部软件包。它通常用于查找和配置第三方库或工具，并将它们的信息（如包含目录、库目录、依赖项等）引入到项目中，以便项目可以与这些外部软件包进行交互。

`find_package` 的一般语法如下：

```cmake
find_package(PackageName [version] [EXACT] [QUIET] [MODULE] [REQUIRED]
             [COMPONENTS component1 [component2 ...]])
```

- `PackageName` 是要查找的软件包的名称，例如，`Boost`、`OpenCV`、`Qt` 等。
- `version` 是可选的，用于指定所需的软件包版本。
- `EXACT` 可选，用于要求版本号匹配完全相等。
- `QUIET` 可选，如果找不到软件包，则不会生成错误消息。
- `MODULE` 可选，表示通过CMake模块查找软件包。
- `REQUIRED` 可选，如果软件包未找到，将生成致命错误。
- `COMPONENTS` 可选，用于指定软件包的组件，例如，库、头文件等。

例如，要在CMake项目中查找并导入Boost C++库，可以使用以下方式：

```cmake
find_package(Boost 1.70 REQUIRED)
```

这将查找Boost库的最低版本为1.70，并将其包含目录、库目录以及其他信息引入到项目中，以便在项目中使用Boost。

`find_package` 的确切用法和可用的选项取决于要查找的软件包和CMake模块是否可用。每个软件包通常都有自己的CMake模块或配置文件，用于帮助CMake查找和配置该软件包。你可以查阅软件包的文档或CMake文档以获取详细信息。



## 自定义的包如何让cmake找到

**我下载了一个包  安装目录在/bin/myPath 里面有bin 可执行文件 include 头文件 lib 库文件三个文件夹，我应该如何设置 才可以让cmake自动找到**

如果你下载了一个包并将其安装到 `/bin/myPath` 目录，该目录包含了 `bin`、`include` 和 `lib` 三个子文件夹，你可以按照以下步骤来配置CMake以便自动找到这个包：

1. **设置CMake模块路径**：首先，你可以设置CMake模块路径，以便CMake能够查找到你的包。假设你的包没有提供自己的 `Find<PackageName>.cmake` 模块文件，你可以将 `/bin/myPath` 添加到 `CMAKE_PREFIX_PATH` 中，如下所示：

   ```bash
   export CMAKE_PREFIX_PATH="/bin/myPath:$CMAKE_PREFIX_PATH"
   ```

   这会将 `/bin/myPath` 添加到CMake的搜索路径中，以便CMake能够查找到你的包。

2. **在CMakeLists.txt中查找包**：在你的项目的 `CMakeLists.txt` 文件中，使用 `find_package` 命令来查找并导入你的包。假设你的包的名称是 `MyPackage`，可以这样设置：

   ```cmake
   find_package(MyPackage REQUIRED)
   ```

   `REQUIRED` 可以根据你的需求添加或删除，如果你需要确保包存在，可以保留它。

3. **使用导入的信息**：一旦 `find_package` 成功找到并导入你的包，你可以使用相应的CMake变量来配置和构建你的项目，以便与这个包进行交互。例如，你可以使用 `MyPackage_INCLUDE_DIRS` 来设置头文件目录，使用 `MyPackage_LIBRARIES` 来链接库文件。

   ```cmake
   include_directories(${MyPackage_INCLUDE_DIRS})
   target_link_libraries(your_target ${MyPackage_LIBRARIES})
   ```

   请根据你的项目需求和包的特性来设置这些变量。

通过执行以上步骤，你应该能够使CMake能够自动找到你下载的包并在项目中使用它。确保查阅你的包的文档以获取特定配置要求和变量的详细信息。



## cmake找到包后会自动设置的一些变量

- find_package(Boost 1.70 REQUIRED) 如果找到包了 会自动设置一些什么变量

- 当你在 CMake 中使用 `find_package(Boost 1.70 REQUIRED)`，并且成功找到了相应版本的 Boost 库，CMake 会设置一些变量，这些变量可以在你的 CMake 脚本中使用。以下是一些主要的变量：

  1. **`Boost_FOUND`**: 如果找到了 Boost 库，这个变量会被设置为 `TRUE`。如果未找到，或者找到的版本不符合要求，它会被设置为 `FALSE`。当使用 `REQUIRED` 标志时，如果未找到 Boost，CMake 会停止处理并报错。

  2. **`Boost_INCLUDE_DIRS`**: 包含 Boost 头文件的目录。你可以使用这个变量将 Boost 的头文件目录添加到你的目标中，例如使用 `include_directories(${Boost_INCLUDE_DIRS})`。

  3. **`Boost_LIBRARY_DIRS`**: 包含 Boost 库文件的目录。这个变量通常用于链接设置。

  4. **`Boost_LIBRARIES`**: 这个变量包含了要链接的 Boost 库的完整路径。如果你请求了特定的组件（如 `find_package(Boost 1.70 REQUIRED COMPONENTS system filesystem)`），则只有那些组件会包含在此变量中。

  5. **`Boost_VERSION`**: 实际找到的 Boost 版本。

  使用这些变量可以在你的项目中方便地设置包含路径、链接库等。例如，你可以这样链接 Boost 库：

  ```cmake
  target_include_directories(your_target PRIVATE ${Boost_INCLUDE_DIRS})
  target_link_libraries(your_target ${Boost_LIBRARIES})
  ```

  请注意，如果你请求了特定的 Boost 组件，你需要在 `find_package` 命令中明确指定这些组件，否则 `Boost_LIBRARIES` 变量可能不会包含你需要的所有库。例如：

  ```cmake
  find_package(Boost 1.70 REQUIRED COMPONENTS system filesystem)
  ```

  这将会查找 Boost，并确保 `system` 和 `filesystem` 库可用，然后这些库的路径会被添加到 `Boost_LIBRARIES` 变量中。





## 如何找包名称

在 CMake 中，`find_package` 命令可以用来查找两种类型的包配置文件：`Find<PackageName>.cmake` 和 `<PackageName>Config.cmake`（或 `<小写包名>-config.cmake`）。这两种文件有些不同的用途和行为：

1. **`Find<PackageName>.cmake`**:
   - 这种类型的模块是由 CMake 或项目的维护者提供的。
   - 它们通常用于查找已安装在标准位置的库（如 `/usr/local/lib` 或 Windows 上的 `C:\Program Files`）。
   - 这些文件提供了查找库的逻辑，包括如何确定库的位置、版本和其他细节。
   - `Find<PackageName>.cmake` 模块通常位于 CMake 的模块路径中，这意味着它们随 CMake 一起分发。

2. **`<PackageName>Config.cmake` 或 `<小写包名>-config.cmake`**:
   - 这种类型的文件通常由库的开发者提供，并随库一起安装。
   - 它们包含了特定于该库的配置信息，使得 CMake 可以在不需要编写额外查找逻辑的情况下，使用这些库。
   - 这些配置文件更加具体和准确，因为它们是为特定库版本编写的。

当您使用 `find_package` 时，CMake 首先会寻找 `<PackageName>Config.cmake` 或 `<小写包名>-config.cmake` 文件。如果这些文件不存在，它会回退到查找 `Find<PackageName>.cmake` 模块。

例如，当您执行 `find_package(Boost REQUIRED COMPONENTS system)` 时，CMake 会按以下顺序进行搜索：

1. 首先搜索 `BoostConfig.cmake` 或 `boost-config.cmake`。
2. 如果找不到配置文件，它会搜索 `FindBoost.cmake` 模块。

这样的设计使得 CMake 既能够处理那些提供了详细配置文件的现代库，也能处理那些较老或没有提供此类配置文件的库。





## 如何解释QT里面的

```cmake
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)
```



当您使用以下 CMake 命令时：

```cmake
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
```

这个命令的作用是指示 CMake 去寻找 Qt6 或 Qt5，确保它们包含 `Widgets` 组件。不过，CMake 实际上并不是直接寻找 `Qt6Widgets.cmake` 或 `Qt5Widgets.cmake` 这样的文件。让我解释一下它实际上是如何工作的：

1. **查找 Qt 的配置文件**:
   - CMake 首先会在 `CMAKE_PREFIX_PATH` 指定的路径下（以及其他标准或预定义的路径）寻找 `Qt6Config.cmake` 或 `Qt5Config.cmake`（根据指定的名称 `Qt6` 或 `Qt5`）。
   - 这些配置文件是由 Qt 安装程序提供的，包含了如何使用 Qt 库的必要信息，包括它的组件如何被配置和链接。

2. **加载组件信息**:
   - 一旦找到 Qt 的配置文件，CMake 会使用其中的信息来查找和设置请求的 `Widgets` 组件。
   - 在 Qt 的情况下，配置文件知道如何处理这些组件请求，并且会设置必要的变量和目标，以便您能够在项目中链接到和使用 `Widgets` 组件。

3. **设置 `QT_VERSION_MAJOR`**:
   - 在成功找到 Qt 包后，`QT_VERSION_MAJOR` 变量会被设置，表示找到的 Qt 的主版本号（例如 `5` 或 `6`）。

然后，第二条命令：

```cmake
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)
```

- 这一步使用先前设置的 `QT_VERSION_MAJOR` 变量来确定是查找 Qt5 还是 Qt6 的 `Widgets` 组件。
- 如果 `QT_VERSION_MAJOR` 是 `6`，这一行等同于 `find_package(Qt6 REQUIRED COMPONENTS Widgets)`；如果是 `5`，则等同于 `find_package(Qt5 REQUIRED COMPONENTS Widgets)`。

综上所述，`find_package` 在寻找 Qt 库时，并不是直接寻找特定的 `Qt6Widgets.cmake` 或 `Qt5Widgets.cmake` 文件，而是通过 Qt 提供的配置文件来了解如何加载和使用所请求的组件。





# 找包高级用法

```cmake
cmake_minimum_required(VERSION 3.10)
project(MyProject C)

set(CMAKE_C_STANDARD 11)

# OpenSSL path
set(OPENSSL_ROOT_DIR /opt/homebrew/Cellar/openssl@3/3.2.1)

find_package(OpenSSL REQUIRED)
#find_package 会生成3个变量
	#OPENSSL_FOUND：如果找到了 OpenSSL，这个变量会被设置为 TRUE。
	#OPENSSL_INCLUDE_DIR：这个变量包含了 OpenSSL 头文件的路径。
	#OPENSSL_LIBRARIES：这个变量包含了需要链接的 OpenSSL 库。
	#OPENSSL_VERSION：这个变量包含了找到的 OpenSSL 的版本。
add_executable(aes aes.c)

target_include_directories(aes PRIVATE ${OPENSSL_INCLUDE_DIR})
target_link_libraries(aes PRIVATE OpenSSL::Crypto)

```
找包的时候 find_package(abc REQUIRED)的时候 会优先到 ABC_ROOT_PATH里面找
所以最好提前定义好变量set(ABC_ROOT_PATH "your path")

