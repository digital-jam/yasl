import Foundation

/// Makes possible to add type metadata to value.
public enum TypeWrapper {
    case null
    case int(Int)
    case unsignedLong(UInt64)
    case bool(Bool)
    case double(Double)
    case string(String)
    case array([TypeWrapper])
    case dictionary([String: TypeWrapper])
}

/// A simple generic `CodingKey`. Used mostly by unkeyed containers to keep
/// track of indexes in a coding path. A shame none of the several copies of
/// exactly this in the standard library are public.
public struct GenericCodingKey: CodingKey {
    public let stringValue: String
    public let intValue: Int?

    public init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }

    public init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
}

extension TypeWrapper: Codable {
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: GenericCodingKey.self) {
            var dict = [String: TypeWrapper]()
            try container.allKeys.forEach { (key) throws in
                dict[key.stringValue] = try container.decode(TypeWrapper.self, forKey: key)
            }
            self = .dictionary(dict)
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [TypeWrapper]()
            while !container.isAtEnd {
                result.append(try container.decode(TypeWrapper.self))
            }
            self = .array(result)
        } else if let container = try? decoder.singleValueContainer() {
            if let integer = try? container.decode(Int.self) {
                self = .int(integer)
            } else if let float = try? container.decode(Double.self) {
                self = .double(float)
            } else if let bool = try? container.decode(Bool.self) {
                self = .bool(bool)
            } else if let string = try? container.decode(String.self) {
                self = .string(string)
            } else {
                self = .null
            }
        } else {
            self = .null
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null: try container.encodeNil()
        case .int(let integer): try container.encode(integer)
        case .unsignedLong(let longUnsigned): try container.encode(longUnsigned)
        case .bool(let bool): try container.encode(bool)
        case .double(let float): try container.encode(float)
        case .string(let string): try container.encode(string)
        case .array(let items): try container.encode(items)
        case .dictionary(let dict): try container.encode(dict)
         }
    }
}

extension TypeWrapper: CustomStringConvertible {
    public var description: String {
        guard let data = try? JSONEncoder.init().encode(self),
              let result = String(data: data, encoding: .utf8) else { return "" }

        return result
    }
}
