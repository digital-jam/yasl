import Foundation

/// Output of the Logger. The purpose of the protocol to abstract way of handling the log event (write to file, write to output stream, send via http, etc)
public protocol LogBackend {
    func log(level: Level,
             message: Message,
             source: String?,
             file: String, function: String, line: UInt)

    var logLevel: Level { get }
    var preferredMessageType: Message.Kind { get }
}

extension LogBackend {
    public var logLevel: Level { .trace  }
    public var preferredMessageType: Message.Kind { .regular }
}
