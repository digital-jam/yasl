/// Protocol that describes shape of logger.
public protocol ILogger {
    /// Log a message passing the log level as a parameter. 
    func log(level: Level,
             message: Message,
             file: String, function: String, line: UInt)
}

@inlinable func createMessage(of string: String, with args: [TypeWrapperRepresentable]) -> Message {
    args.count != 0 ? Message.templated(string, args) : .regular(string)
}

public extension ILogger {
    @inlinable func debug(_ message: Message,
                        file: String = #file, function: String = #function, line: UInt = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    @inlinable func info(_ message: Message,
                        file: String = #file, function: String = #function, line: UInt = #line) {
        log(level: .info, message: message, file: file, function: function, line: line)
    }

    @inlinable func warning(_ message: Message,
                        file: String = #file, function: String = #function, line: UInt = #line) {
        log(level: .warning, message: message, file: file, function: function, line: line)
    }

    @inlinable func error(_ message: Message,
                        file: String = #file, function: String = #function, line: UInt = #line) {
        log(level: .error, message: message, file: file, function: function, line: line)
    }

    @inlinable func error(_ error: Error,
                        file: String = #file, function: String = #function, line: UInt = #line) {
        log(level: .error, message: .regular(error.localizedDescription),
            file: file, function: function, line: line)
    }

    @inlinable func critical(_ message: Message,
                             file: String = #file, function: String = #function, line: UInt = #line) {
        log(level: .critical, message: message, file: file, function: function, line: line)
    }

    @inlinable func debug(_ message: String,
                        file: String = #file, function: String = #function, line: UInt = #line,
                        args: TypeWrapperRepresentable...) {
        self.debug(createMessage(of: message, with: args),
                   file: file, function: function, line: line)
    }

    @inlinable func info(_ message: String,
                        file: String = #file, function: String = #function, line: UInt = #line,
                        args: TypeWrapperRepresentable...) {
        self.info(createMessage(of: message, with: args),
                   file: file, function: function, line: line)
    }

    @inlinable func warning(_ message: String,
                        file: String = #file, function: String = #function, line: UInt = #line,
                        args: TypeWrapperRepresentable...) {
        self.warning(createMessage(of: message, with: args),
                   file: file, function: function, line: line)
    }

    @inlinable func error(_ message: String,
                        file: String = #file, function: String = #function, line: UInt = #line,
                        args: TypeWrapperRepresentable...) {
        self.error(createMessage(of: message, with: args),
                   file: file, function: function, line: line)
    }

    @inlinable func critical(_ message: String,
                        file: String = #file, function: String = #function, line: UInt = #line,
                        args: TypeWrapperRepresentable...) {
        self.critical(createMessage(of: message, with: args),
                   file: file, function: function, line: line)
    }
}
