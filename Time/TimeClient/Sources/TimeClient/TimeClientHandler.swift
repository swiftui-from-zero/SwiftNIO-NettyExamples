 //
//  Created by Zilin Zhu on 2021/2/14.
//

import Foundation
import NIO

 class TimeClientHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var m: ByteBuffer = unwrapInboundIn(data)
        
        if let currentSecond = m.readInteger(endianness: .big, as: Int.self) {
            let date = Date(timeIntervalSince1970: Double(currentSecond))
            print(date)
        } else {
            print("failed to convert the response to Int.")
        }
        context.close()
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
