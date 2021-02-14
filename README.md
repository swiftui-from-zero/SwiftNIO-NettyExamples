# 用 SwiftNIO 实现的 Netty 例子

看过 SwiftNIO 文档的朋友想必都见过这样的一句话：

> It's like Netty, but written for Swift.

SwiftNIO 和 Netty 的关系非常近，其开发团队的核心人员 [Norman Maurer](https://github.com/normanmaurer) 也是 Netty 的主要开发者。SwiftNIO 也直接采用了 Netty 中的很多概念和架构。在 SwiftNIO 的文档还不甚完善的今天，不妨让我们通过 Netty 的文档来学习这个框架~

本项目用 SwiftNIO 实现了 Netty 文档中 [Getting Started](https://netty.io/wiki/user-guide-for-4.x.html#getting-started) 一节涉及到的 `DISCORD`, `ECHO`, `TIME` 三个框架，并配以了中文注释，希望可以帮您更好的学习 SwiftNIO。