//
//  Created by Zilin Zhu on 2021/2/14.
//

import Foundation
import NIO

// TODO: use @main in TimeServer to make it more like
// the origin netty example.
class TimeServer {
    private let port: Int

    init(_ port: Int) {
        self.port = port
    }

    func run() throws {
        let bossGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount);
        let workerGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

        defer {
            try! bossGroup.syncShutdownGracefully()
            try! workerGroup.syncShutdownGracefully()
        }

        let b = ServerBootstrap(group: bossGroup, childGroup: workerGroup)
            .childChannelInitializer { ch in
                ch.pipeline.addHandler(TimeServerHandler())
            }
            .serverChannelOption(ChannelOptions.backlog, value: 128)
            .childChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_KEEPALIVE), value: 1)
        
        let channel = try b.bind(host: "localhost", port: port).wait()
        
        try channel.closeFuture.wait()
    }

    static func main(_ port: Int = 8080) throws {
        try TimeServer(port).run()
    }
}
