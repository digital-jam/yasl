import Foundation

/// Default implementation of logger.
public class Logger: ILogger {
    public let backend: LogBackend
    public let source: String?

    public init(source: String? = nil) {
        self.backend = LoggingSystem.factory()
        self.source = source
    }

    @inlinable
    open func log(level: Level,
                  message: Message,
                  file: String = #file, function: String = #function, line: UInt = #line) {
        if backend.logLevel <= level {
            backend.log(level: level, message: message, source: source,
                       file: file, function: function, line: line)
        }
    }
}
