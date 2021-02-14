//
//  Created by Zilin Zhu on 2021/2/14.
//

import Foundation
import NIO

class TimeDecoder: ByteToMessageDecoder {
    typealias InboundOut = ByteBuffer
    
    func decode(context: ChannelHandlerContext, buffer: inout ByteBuffer) throws -> DecodingState {
        // Swift 的 Int 默认是 Int64
        if buffer.readableBytes < 8 {
            return .needMoreData
        }
        // 需要我们主动取出需要的部分，并调用 fireChannelRead 来让下一个 handler 处理
        let slice = buffer.readSlice(length: 8)!
        context.fireChannelRead(wrapInboundOut(slice))
        return .continue
    }
}
