import Foundation
import NIO

class TimeServerHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    
    func channelActive(context: ChannelHandlerContext) {
        // 通过这种方式切换到当地时间
        let timezoneOffset = TimeZone.current.secondsFromGMT()
        let time = ByteBuffer(integer: Int(Date().timeIntervalSince1970) + timezoneOffset,
                              endianness: .big, as: Int.self)
        let f: EventLoopFuture = context.writeAndFlush(NIOAny(time))
        f.flatMap {
            context.close()
        }
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
