---
layout: default
title: "cmake 默认变量"
---
- **CMAKE_BUILD_TYPE    构建类型**
    - Release
    - Debug
- **CMAKE_SIZEOF_VOID 指针大小**
    - 8
- **CMAKE_SYSTEM_NAME 系统名称**
    - Darwin mac系统
- **CMAKE_CXX_COMPILER C++编译器**

    - 编译器路径
- **CMAKE_C_STANDARD  C标准**
    - C11
- **CMAKE_INSTALL_PREFIX 安装路径**
    -   用一下命令可以安装到指定路径
    -   install(TARGETS my_app DESTINATION bin) 安装可执行文件
        项目名称 my_app 会安装到 ${CMAKE_INSTALL_PREFIX}/bin 里面
    -   install(FILES my_library/my_header.h DESTINATION include) 安装头文件
    -   install(TARGETS my_library DESTINATION lib)
- **CMAKE_CURRENT_LIST_DIR**
    - 当前处理cmake文件的目录


---

---

---

---

template

- ---
