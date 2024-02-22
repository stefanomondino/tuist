import Foundation

// MARK: - Plist

public enum Plist {
    /// It represents the values of the .plist or .entitlements file dictionary.
    /// It ensures that the values used to define the content of the dynamically generated .plist or .entitlements files are valid
    public indirect enum Value: Codable, Equatable {
        /// It represents a string value.
        case string(String)
        /// It represents an integer value.
        case integer(Int)
        /// It represents a floating value.
        case real(Double)
        /// It represents a boolean value.
        case boolean(Bool)
        /// It represents a dictionary value.
        case dictionary([String: Value])
        /// It represents an array value.
        case array([Value])
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
        
            if let value = try? container.decode(String.self) {
                self = .string(value)
            } else if let value = try? container.decode(Int.self) {
                self = .integer(value)
            } else if let value = try? container.decode(Double.self) {
                self = .real(value)
            } else if let value = try? container.decode(Bool.self) {
                self = .boolean(value)
            } else if let value = try? container.decode([String: Value].self) {
                self = .dictionary(value)
            } else if let value = try? container.decode([Value].self) {
                self = .array(value)
            } else {
                // Should never happen
                throw DecodingError.valueNotFound(Value.self, .init(codingPath: [],
                                                                    debugDescription: "Unable to decode"))
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .string(value): try container.encode(value)
            case let .integer(value): try container.encode(value)
            case let .real(value): try container.encode(value)
            case let .boolean(value): try container.encode(value)
            case let .dictionary(value): try container.encode(value)
            case let .array(value): try container.encode(value)
            }
        }
    }
}

// MARK: - Plist.Value - ExpressibleByStringInterpolation

extension Plist.Value: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

// MARK: - Plist.Value - ExpressibleByIntegerLiteral

extension Plist.Value: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .integer(value)
    }
}

// MARK: - Plist.Value - ExpressibleByFloatLiteral

extension Plist.Value: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .real(value)
    }
}

// MARK: - Plist.Value - ExpressibleByBooleanLiteral

extension Plist.Value: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .boolean(value)
    }
}

// MARK: - Plist.Value - ExpressibleByDictionaryLiteral

extension Plist.Value: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Plist.Value)...) {
        self = .dictionary(Dictionary(uniqueKeysWithValues: elements))
    }
}

// MARK: - Plist.Value - ExpressibleByArrayLiteral

extension Plist.Value: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Plist.Value...) {
        self = .array(elements)
    }
}
