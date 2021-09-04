import Foundation

/// Dummy backend that does nothing with accepted logs. Useful for testing.
class NoOpLogBackend: LogBackend {
    func log(level: Level, message: Message, source: String?,
             file: String, function: String, line: UInt) { }

    var logLevel: Level = .critical
}
