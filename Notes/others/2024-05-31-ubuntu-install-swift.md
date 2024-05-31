---
layout: post
author: "大西瓜"
title: "ubuntu install swift"
date:   2024-05-31 10:30:23 +0800
categories: [update,others] 
---

在 Ubuntu 上搭建 Swift 开发环境包括安装 Swift 编译器和设置开发工具。以下是详细的步骤：

### 1. 更新系统并安装依赖

首先，确保你的系统是最新的，并安装一些必要的依赖包：

```sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y clang libcurl4-openssl-dev libpython3.8 libpython3.8-dev libicu-dev git
```

### 2. 下载 Swift 编译器

前往 Swift 官方下载页面，选择适合你 Ubuntu 版本的 Swift 编译器（例如，Ubuntu 20.04 或 22.04）。

[Swift Downloads](https://swift.org/download/)

### 3. 安装 Swift 编译器

下载并解压 Swift 编译器：

```sh
# 下载 Swift 编译器（替换 URL 为实际下载链接）
wget https://swift.org/builds/swift-5.7.3-release/ubuntu2004/swift-5.7.3-RELEASE/swift-5.7.3-RELEASE-ubuntu20.04.tar.gz

# 解压下载的文件
tar xzf swift-5.7.3-RELEASE-ubuntu20.04.tar.gz

# 移动解压后的 Swift 文件夹到 /usr/local/
sudo mv swift-5.7.3-RELEASE-ubuntu20.04 /usr/local/swift-5.7.3
```

### 4. 设置环境变量

为了方便使用 Swift 编译器，添加 Swift 到你的环境变量中：

```sh
echo 'export PATH=/usr/local/swift-5.7.3/usr/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### 5. 验证安装

检查 Swift 是否安装成功：

```sh
swift --version
```

你应该会看到 Swift 的版本信息，表明安装成功。

### 6. 使用 Swift REPL 和编译器

你可以使用 Swift 的 REPL（Read-Eval-Print Loop）来交互式地运行 Swift 代码：

```sh
swift
```

退出 REPL，可以使用 `:quit` 或者 `Ctrl+D`。

### 7. 创建和编译 Swift 项目

你可以创建一个简单的 Swift 文件并编译：

```sh
# 创建一个简单的 Swift 文件
echo 'print("Hello, Swift on Ubuntu!")' > hello.swift

# 编译并运行
swiftc hello.swift -o hello
./hello
```

### 8. 使用 Swift Package Manager（SPM）

Swift 包管理器（SPM）是 Swift 的内置工具，可以用来管理依赖和构建项目。以下是使用 SPM 创建和构建项目的步骤：

1. **创建新项目**：
   ```sh
   mkdir MySwiftProject
   cd MySwiftProject
   swift package init --type executable
   ```

2. **构建和运行项目**：
   ```sh
   swift build
   .build/debug/MySwiftProject
   ```

3. **编辑 `Sources/MySwiftProject/main.swift`** 文件来编写你的 Swift 代码。

通过这些步骤，你可以在 Ubuntu 上成功搭建和使用 Swift 开发环境。更多详细信息可以参考 Swift 官方文档和 Ubuntu 社区指南。
