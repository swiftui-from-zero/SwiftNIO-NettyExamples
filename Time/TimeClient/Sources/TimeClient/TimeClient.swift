//
//  Created by Zilin Zhu on 2021/2/14.
//

import Foundation
import NIO

class TimeClient {
    static func main(host: String = "localhost", port: Int = 8080) throws {
        let workGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount);
        
        defer {
            try! workGroup.syncShutdownGracefully()
        }
        
        let b = ClientBootstrap(group: workGroup)
            .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_KEEPALIVE), value: 1)
            .channelInitializer { ch in
                ch.pipeline.addHandlers([ByteToMessageHandler(TimeDecoder()),
                                         TimeClientHandler()])
            }
        
        let channel = try b.connect(host: host, port: port).wait()
        try channel.closeFuture.wait()
    }
}
