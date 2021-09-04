import Foundation

/// The backend gives ability to compose multiple LogBackends into one.
public class MultiplexLogBackend: LogBackend {
    public let backends: [LogBackend]
    public let logLevel: Level

    public init(_ backends: [LogBackend]) {
        assert(!backends.isEmpty, "MultiplexLogHandler.backends MUST NOT be empty")
        self.backends = backends
        self.logLevel = backends.map { $0.logLevel }.min() ?? .trace
    }

    @inlinable
    public func log(level: Level, message: Message, source: String?,
             file: String, function: String, line: UInt) {
        for backend in self.backends where backend.logLevel <= level {
            backend.log(level: level, message: message, source: source,
                       file: file, function: function, line: line)
       }
    }
}
