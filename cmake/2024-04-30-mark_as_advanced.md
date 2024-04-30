---
layout: default
title: "mark_as_advanced"
---
## cmake 里面mark_as_advanced 如何使用

### GitHub Copilot



`mark_as_advanced` 是 CMake 中的一个命令，它用于将一个或多个缓存变量标记为高级选项。高级选项在 CMake GUI 中默认是隐藏的，只有当用户选择显示高级选项时，这些选项才会显示出来。这可以帮助简化配置界面，只显示最常用的选项。

`mark_as_advanced` 命令的基本用法如下：

mark_as_advanced(<variable1> <variable2> ...)

其中，`<variable1> <variable2> ...` 是你想要标记为高级选项的缓存变量的名称。

例如，假设你有两个缓存变量 `MY_OPTION1` 和 `MY_OPTION2`，你可以使用以下命令将它们标记为高级选项：

mark_as_advanced(MY_OPTION1 MY_OPTION2)

然后，`MY_OPTION1` 和 `MY_OPTION2` 就会在 CMake GUI 中被隐藏，除非用户选择显示高级选项。

如果你想要取消标记一个高级选项，你可以使用 `mark_as_advanced(CLEAR ...)` 命令：

mark_as_advanced(CLEAR MY_OPTION1 MY_OPTION2)

这样，`MY_OPTION1` 和 `MY_OPTION2` 就会在 CMake GUI 中始终显示，无论用户是否选择显示高级选项。





## 只是在cmake-gui里面隐藏吗

### GitHub Copilot



是的，`mark_as_advanced` 主要是在 CMake GUI 中影响变量的显示。它将指定的缓存变量标记为高级选项，这些高级选项在 CMake GUI 中默认是隐藏的，只有当用户选择显示高级选项时，这些选项才会显示出来。

然而，这并不影响这些变量在 CMakeLists.txt 文件或命令行中的使用。无论一个变量是否被标记为高级选项，你都可以在 CMakeLists.txt 文件中使用它，或者在命令行中通过 `-D` 选项设置它。

例如，即使 `MY_OPTION` 被标记为高级选项，你仍然可以在 CMakeLists.txt 文件中使用它：

if(MY_OPTION)

  \# do something

endif()

或者在命令行中设置它：

cmake -DMY_OPTION=ON ..

`mark_as_advanced` 只是改变了这些变量在 CMake GUI 中的显示，不会影响它们的功能。