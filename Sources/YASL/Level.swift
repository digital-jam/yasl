import Foundation

/// The log level.
///
/// Log levels are ordered by their severity, with `.trace` being the least severe and
/// `.critical` being the most severe.
public enum Level: String, Codable, CaseIterable {
    /// Appropriate for messages that contain information normally of use only when
    /// tracing the execution of a program.
    case trace

    /// Appropriate for messages that contain information normally of use only when
    /// debugging a program.
    case debug

    /// Appropriate for informational messages.
    case info

    /// Appropriate for conditions that are not error conditions, but that may require
    /// special handling.
    case notice

    /// Appropriate for messages that are not error conditions, but more severe than
    /// `.notice`.
    case warning

    /// Appropriate for error conditions.
    case error

    /// Appropriate for critical error conditions that usually require immediate
    /// attention.
    ///
    /// When a `critical` message is logged, the logging backend (`LogHandler`) is free to perform
    /// more heavy-weight operations to capture system state (such as capturing stack traces) to facilitate
    /// debugging.
    case critical
}

extension Level {
    internal var naturalIntegralValue: Int {
        switch self {
        case .trace:
            return 0
        case .debug:
            return 1
        case .info:
            return 2
        case .notice:
            return 3
        case .warning:
            return 4
        case .error:
            return 5
        case .critical:
            return 6
        }
    }
}

extension Level: Comparable {
    public static func < (lhs: Level, rhs: Level) -> Bool {
        return lhs.naturalIntegralValue < rhs.naturalIntegralValue
    }
}
