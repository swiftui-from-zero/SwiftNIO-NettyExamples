//
//  Created by Zilin Zhu on 2021/2/14.
//

import Foundation
import NIO

class EchoServerHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        // 注意这里不用管 write 的返回值
        context.write(data)
        context.flush()
    }
    
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("\(error.localizedDescription)")
        context.close()
    }
}
