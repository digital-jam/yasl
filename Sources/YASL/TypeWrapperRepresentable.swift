import Foundation

public protocol TypeWrapperRepresentable {
    var typeWrappedValue: TypeWrapper { get }
}

extension Optional: TypeWrapperRepresentable where Wrapped == TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper {
        guard let self = self else {
            return .null
        }

        return self.typeWrappedValue
    }
}

extension Int: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { .int(self) }
}

extension UInt64: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { .unsignedLong(self) }
}

extension Bool: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { .bool(self) }
}

extension Double: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { .double(self) }
}

extension String: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { .string(self) }
}

extension Array: TypeWrapperRepresentable where Element: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { .array(self.map { $0.typeWrappedValue }) }
}

extension Dictionary: TypeWrapperRepresentable where Value: TypeWrapperRepresentable, Key: CustomStringConvertible {
    public var typeWrappedValue: TypeWrapper {
        var result: [String:TypeWrapper] = [:]
        self.forEach { key, value in
            result[key.description] = value.typeWrappedValue
        }
        return .dictionary(result)
    }
}

extension TypeWrapper: TypeWrapperRepresentable {
    public var typeWrappedValue: TypeWrapper { self }
}
