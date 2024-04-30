---
layout: default
title: "include_directories"
---
## include_directories 是全局可见吗

### **仅限于当前的 CMakeLists.txt 文件以及它下面的子目录中的 CMakeLists.txt 文件**



`include_directories` 命令在 CMake 中用于添加包含目录，这些目录将被编译器用于查找头文件。这个命令添加的目录对于在该命令之后定义的所有目标都是可见的。

但是，`include_directories` 命令的影响范围**仅限于当前的 CMakeLists.txt 文件以及它下面的子目录中的 CMakeLists.txt 文件**。也就是说，它不会影响到其他的兄弟目录或者父目录。

如果你想要在整个项目中都添加一个包含目录，你应该在最顶层的 CMakeLists.txt 文件中使用 `include_directories` 命令。

另外，从 CMake 3.0.0 开始，推荐使用 `target_include_directories` 命令来为特定的目标添加包含目录，这样可以更好地控制目录的可见性。例如：

```cmake
target_include_directories(myTarget PUBLIC /path/to/includes)
```

在这个例子中，`/path/to/includes` 目录将被添加到 `myTarget` 目标的包含目录中，`PUBLIC` 关键字表示这个目录对于 `myTarget` 以及任何链接到 `myTarget` 的目标都是可见的。