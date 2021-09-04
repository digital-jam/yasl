import Foundation

/// Class to configure application wide logging.
public class LoggingSystem {
    internal static var factory: () -> LogBackend = { NoOpLogBackend() }
    fileprivate static var initialized = false

    public static func bootstrap(_ factory: @escaping () -> LogBackend) {
        precondition(!self.initialized, "Logging system can only be initialized once per process.")
        self.factory = factory
        self.initialized = true
    }
}
