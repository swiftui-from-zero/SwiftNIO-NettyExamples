# 用 SwiftNIO 实现的 Netty 例子

看过 SwiftNIO 文档的朋友想必都见过这样的一句话：

> It's like Netty, but written for Swift.

SwiftNIO 和 Netty 的关系非常近，其开发团队的核心人员 [Norman Maurer](https://github.com/normanmaurer) 也是 Netty 的主要开发者。SwiftNIO 也直接采用了 Netty 中的很多概念和架构。在 SwiftNIO 的文档还不甚完善的今天，不妨让我们通过 Netty 的文档来学习这个框架~

本项目用 SwiftNIO 实现了 Netty 文档中 [Getting Started](https://netty.io/wiki/user-guide-for-4.x.html#getting-started) 一节涉及到的 `DISCORD`, `ECHO`, `TIME` 三个框架，希望可以帮您更好的学习 SwiftNIO。

## Discard

实现了 `DISCARD` 协议，也就是 server 会直接忽略任何 client 发来的信息。用 Xcode 打开项目并启动后，可以用 `netcat` 进行测试：

```bash
$ nc localhost 8080
```

之后的任何输入应该都不会有回复，而是在 server 的 log 中会打印一遍。

## Echo

实现了 `ECHO` 协议，也就是 server 会直接返回 client 发来的任何信息。仍然可以用 `netcat` 进行测试：

```bash
$ nc localhost 8080
```

之后的任何输入都会收到和输入相同的回复。

## Time

实现了 `TIME` 协议，也就是在 client 启动的时刻会收到连接时刻的时间信息，之后 client 就会退出了。因为这里我们要用二进制的方式传输一个 `Int`，所以不能用 `netcat` 进行测试了，在 `Time` 文件夹中有 `TimeServer` 和 `TimeClient` 两个项目，先后启动 server 和 client，就会看到 client 的 log 中输出了连接成功的时刻。