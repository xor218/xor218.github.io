---
layout: post
author: "大西瓜"
title: "airplay udp 广播"
date:   2024-05-05 09:46:43 +0800
categories: [update,Network] 
---
## airplay 用什么端口
AirPlay 是由苹果公司开发的一种无线流媒体协议，用于在 iOS 设备、iPadOS 设备、Mac 计算机和 Apple TV 之间共享音频、视频、设备屏幕和照片。

AirPlay 使用的是 mDNS（多播DNS）服务发现协议，以及一系列不同的网络端口来传输不同类型的内容：

音频流通常使用的是 RTP（实时传输协议）协议，端口是 6000-6001。
视频流和照片则使用的是 AirTunes（即 AirPlay 的前身）协议，端口是 7000。
设备镜像和屏幕共享使用的是 TCP 端口 7100。
请注意，这些端口号可能会因设备和 iOS 版本的不同而有所变化。



## 广播的C代码
在 C 语言中，我们通常使用 BSD socket API 来进行网络编程。但是，TCP 协议本身并不支持广播，广播通常是在 UDP 协议中使用的。TCP 是一种面向连接的协议，需要在客户端和服务器之间建立一个明确的连接。

如果你想要检测网络上的设备是否在监听特定的 TCP 端口，你可能需要对每个设备进行连接尝试。这通常被称为端口扫描，但请注意，未经授权的端口扫描可能会违反法律或网络政策。

如果你只是想要在本地网络中广播数据，你可以使用 UDP 广播。以下是一个使用 UDP 广播的简单 C 语言示例：

```c++
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT 7100

int main() {
    int sockfd;
    struct sockaddr_in broadcastAddr;
    char *broadcastIP = "255.255.255.255"; // 广播地址
    char *message = "Hello, World!"; // 广播消息

    if ((sockfd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
        perror("socket() failed");
        exit(1);
    }

    // 设置 socket 选项，允许广播
    int broadcastPermission = 1;
    if (setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, (void *) &broadcastPermission, sizeof(broadcastPermission)) < 0) {
        perror("setsockopt() failed");
        exit(1);
    }

    // 构造广播地址结构
    memset(&broadcastAddr, 0, sizeof(broadcastAddr));
    broadcastAddr.sin_family = AF_INET;
    broadcastAddr.sin_addr.s_addr = inet_addr(broadcastIP);
    broadcastAddr.sin_port = htons(PORT);

    // 发送广播消息
    if (sendto(sockfd, message, strlen(message), 0, (struct sockaddr *) &broadcastAddr, sizeof(broadcastAddr)) != strlen(message)) {
        perror("sendto() sent a different number of bytes than expected");
        exit(1);
    }

    close(sockfd);
    return 0;
}
```

这个程序会创建一个 UDP socket，然后向端口 7100 发送一个广播消息。请注意，你可能需要 root 权限才能运行这个程序。

