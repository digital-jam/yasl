import Foundation

/// Unit to log.
public enum Message {
    case regular(String)
    case templated(String, [TypeWrapper])

    public enum Kind {
        case regular, templated
    }
}

public extension Message {
    static func templated(_ string: String, arguments: TypeWrapperRepresentable...) -> Message {
        .templated(string, arguments.map { $0.typeWrappedValue })
    }

    static func templated(_ string: String, _ arguments: [TypeWrapperRepresentable]) -> Message {
        .templated(string, arguments.map { $0.typeWrappedValue })
    }
}

extension Message: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .regular(value)
    }
}
