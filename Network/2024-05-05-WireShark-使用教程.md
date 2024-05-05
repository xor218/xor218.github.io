---
layout: post
author: "大西瓜"
title: "WireShark 使用教程"
date:   2024-05-05 09:32:27 +0800
categories: [update,Network] 
---
# 过滤条件
	Wireshark 过滤器表达式可以按照不同的条件进行分类。以下是一些常见的分类和示例过滤器表达式：

### 1. 按照协议过滤：

- 过滤所有 TCP 流量：
  ```plaintext
  tcp
  ```

- 过滤所有 UDP 流量：
  ```plaintext
  udp
  ```

- 过滤所有 ICMP 流量：
  ```plaintext
  icmp
  ```

### 2. 按照源或目标 IP 地址过滤：

- 过滤特定源 IP 地址的流量：
  ```plaintext
  ip.src == 192.168.1.100
  ```

- 过滤特定目标 IP 地址的流量：
  ```plaintext
  ip.dst == 192.168.1.100
  ```

### 3. 按照端口过滤：

- 过滤特定源端口的流量：
  ```plaintext
  tcp.srcport == 80
  ```

- 过滤特定目标端口的流量：
  ```plaintext
  tcp.dstport == 443
  ```

### 4. 按照数据包方向过滤：

- 过滤发送至特定目标的流量：
  ```plaintext
  ip.dst == 192.168.1.100
  ```

- 过滤从特定源发送的流量：
  ```plaintext
  ip.src == 192.168.1.100
  ```

### 5. 组合条件过滤：

- 过滤特定源 IP 地址和目标端口的 TCP 流量：
  ```plaintext
  ip.src == 192.168.1.100 && tcp.dstport == 80
  ```

- 过滤特定目标 IP 地址或源端口的 UDP 流量：
  ```plaintext
  ip.dst == 192.168.1.100 || udp.srcport == 53
  ```

### 6. 其他过滤条件：

- 过滤特定协议的流量：
  ```plaintext
  http
  ```

- 过滤特定主机名的 DNS 流量：
  ```plaintext
  dns.qry.name == "example.com"
  ```

当然，还有更多过滤器表达式可以帮助你精确地过滤出你感兴趣的网络流量。以下是一些其他常见的过滤器表达式：

### 7. 按照数据包长度过滤：

- 过滤数据包长度大于 100 字节的流量：
  ```plaintext
  frame.length > 100
  ```

- 过滤数据包长度在指定范围内的流量：
  ```plaintext
  frame.length >= 200 && frame.length <= 500
  ```

### 8. 按照数据包类型过滤：

- 过滤出 TCP SYN 数据包（TCP 三次握手的第一个数据包）：
  ```plaintext
  tcp.flags.syn == 1 && tcp.flags.ack == 0
  ```

- 过滤出 TCP FIN 数据包（TCP 连接结束的数据包）：
  ```plaintext
  tcp.flags.fin == 1
  ```

### 9. 按照数据包内容过滤：

- 过滤出包含特定字符串的数据包：
  ```plaintext
  data contains "password"
  ```

- 过滤出指定源 IP 地址发出的 HTTP GET 请求：
  ```plaintext
  ip.src == 192.168.1.100 && http.request.method == "GET"
  ```

### 10. 按照时间过滤：

- 过滤出特定时间范围内的数据包：
  ```plaintext
  frame.time >= "2024-02-24 12:00:00" && frame.time <= "2024-02-24 13:00:00"
  ```

当然，还有更多过滤器表达式可以根据具体的分析需求进行定制。以下是更多示例：

### 11. 按照数据包标志过滤：

- 过滤出设置了 SYN 和 ACK 标志的 TCP 数据包（已建立连接的 TCP 数据包）：
  ```plaintext
  tcp.flags.syn == 1 && tcp.flags.ack == 1
  ```

- 过滤出设置了 RST 标志的 TCP 数据包（TCP 连接复位的数据包）：
  ```plaintext
  tcp.flags.rst == 1
  ```

### 12. 按照流量方向过滤：

- 过滤出来自特定源 IP 到特定目标 IP 的流量：
  ```plaintext
  ip.src == 192.168.1.100 && ip.dst == 192.168.1.200
  ```

- 过滤出与指定主机通信的所有流量：
  ```plaintext
  ip.addr == 192.168.1.100
  ```

### 13. 按照数据包类型过滤：

- 过滤出 ARP 请求数据包：
  ```plaintext
  arp.opcode == 1
  ```

- 过滤出 ICMP 回显请求（ping 请求）：
  ```plaintext
  icmp.type == 8
  ```

### 14. 按照 VLAN 标签过滤：

- 过滤出指定 VLAN ID 的数据包：
  ```plaintext
  vlan.id == 100
  ```

### 15. 按照 DHCP 信息过滤：

- 过滤出 DHCP 请求数据包：
  ```plaintext
  bootp.option.type == 53 && bootp.option.dhcp == 1
  ```

### 16. 按照 SSL/TLS 信息过滤：

- 过滤出 SSL/TLS 加密流量：
  ```plaintext
  ssl || tls
  ```

# 查看DNS的请求和响应
		(ip.addr == 192.168.50.1 && udp.port == 53) || (ip.addr != 192.168.50.1 && udp.srcport == 53)

# 如何获取访问某个url的包呢

ChatGPT

要捕获访问特定 URL 的网络数据包，你可以使用 Wireshark 来过滤出与该 URL 相关的数据包。以下是一些方法：

### 方法一：使用 Wireshark 过滤器表达式

1. **开始捕获流量**：在 Wireshark 中选择要捕获流量的网络接口，并开始捕获数据包。

2. **过滤特定 URL 的流量**：在 Wireshark 过滤器框中使用过滤器表达式来捕获与特定 URL 相关的流量。假设你想要捕获访问 `http://example.com` 的流量，你可以使用以下过滤器表达式：

   ```

   http.host == "example.com"
   ```

   这将只显示与指定 URL `http://example.com` 相关的 HTTP 流量。

### 方法二：使用显示过滤器

1. **开始捕获流量**：在 Wireshark 中选择要捕获流量的网络接口，并开始捕获数据包。
2. **捕获所有 HTTP 流量**：不使用过滤器，捕获所有 HTTP 流量。
3. **查找特定 URL**：在捕获到的数据包列表中，使用 Wireshark 的搜索功能来查找特定 URL。在 Wireshark 界面的菜单栏上，选择 "Edit" -> "Find Packet"，然后输入要搜索的 URL（例如 `example.com`）并点击 "Find".
4. **查看搜索结果**：Wireshark 将定位并突出显示与搜索条件匹配的数据包。你可以检查这些数据包以查看与特定 URL 相关的流量。

使用以上方法，你可以捕获和分析特定 URL 的网络数据包，并了解与该 URL 相关的通信情况。

# 官方url
	https://wiki.wireshark.org/CaptureFilters

