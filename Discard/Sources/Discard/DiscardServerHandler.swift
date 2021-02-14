//
//  Created by Zilin Zhu on 2021/2/13.
//

import Foundation
import NIO

class DiscardServerHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        // swift-nio 版的 ByteBuffer 不用 release
        var msg: ByteBuffer = unwrapInboundIn(data)
        print(msg.readString(length: msg.readableBytes)!)
    }
    
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("\(error.localizedDescription)")
        do {
            // 在出现问题的时候关闭连接
            try context.close().wait()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
