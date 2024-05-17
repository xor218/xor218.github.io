---
layout: default
title: "pkg-config找包"
---

# cmake利用pkg-config来找包

1.	先找find_package 
	find_package(PkgConfig REQUIRED)
2.  利用pkg-config找包
	pkg_check_modules(X11 REQUIRED x11)
	查找x11库 并且变量命名为X11
	如果找到会定义一下变量
		1.	X11_FOUND 为 true
		2.	X11_INCLUDE_DIRS  头文件的目录
		3.	X11_LIBRARY_DIRS  库文件查找目录
		4.	X11_LIBRARIES     库名称

```cmake 
cmake_minimum_required(VERSION 3.21)


project(HelloWorld VERSION 1.0
	LANGUAGES C)



message("PKG_CONFIG_PATH: $ENV{PKG_CONFIG_PATH}")


find_package(PkgConfig REQUIRED)

if(PkgConfig_FOUND)
	message("PkgConfig found")
else()
	message("PkgConfig not found")
endif()

pkg_check_modules(X11 REQUIRED x11)

if(X11_FOUND)
	message(STATUS "X11 found")
	message("头文件:X11_INCLUDE_DIRS: ${X11_INCLUDE_DIRS}")
	message("库名:X11_LIBRARIES: ${X11_LIBRARIES}")
	message("库查找目录:X11_LIBRARY_DIRS: ${X11_LIBRARY_DIRS}")
	message("链接标签:X11_LDFLAGS: ${X11_LDFLAGS}")
	message("链接其他标签： X11_LDFLAGS_OTHER: ${X11_LDFLAGS_OTHER}")
else()
	message("X11 not found")
endif()

add_executable(testX11 main.c)


target_include_directories(testX11 PRIVATE ${X11_INCLUDE_DIRS})
target_link_libraries(testX11 PRIVATE ${X11_LIBRARIES})
target_link_directories(testX11 PRIVATE ${X11_LIBRARY_DIRS})

```



```c
/**
  filename:main.c
*/
#include <X11/Xlib.h>
#include <stdio.h>

int main() {
    Display *display;
    Window window;
    XEvent event;

    // 打开X服务器连接
    display = XOpenDisplay(NULL);
    if (display == NULL) {
        fprintf(stderr, "Cannot open display\n");
        return 1;
    }

    int screen = DefaultScreen(display);

    // 创建窗口
    window = XCreateSimpleWindow(display, RootWindow(display, screen), 10, 10, 500, 500, 1,
                                 BlackPixel(display, screen), WhitePixel(display, screen));

    // 选择感兴趣的事件类型
    XSelectInput(display, window, ExposureMask | KeyPressMask);

    // 显示窗口
    XMapWindow(display, window);

    // 事件循环
    while (1) {
        XNextEvent(display, &event);

        // 当用户关闭窗口时退出
        if (event.type == ClientMessage)
            break;
    }

    // 关闭X服务器连接
    XCloseDisplay(display);

    return 0;

```
