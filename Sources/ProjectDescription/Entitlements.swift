import Foundation

// MARK: - Entitlements

public enum Entitlements: Codable, Equatable {
    /// The path to an existing .entitlements file.
    case file(path: Path)

    /// A dictionary with the entitlements content. Tuist generates the .entitlements file at the generation time.
    case dictionary([String: Plist.Value])

    // MARK: - Error

    public enum CodingError: Error {
        case invalidType(String)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let path = try? container.decode(Path.self) {
            self = .file(path: path)
        } else {
            self = try .dictionary(container.decode([String: Plist.Value].self))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .file(path): try container.encode(path)
        case let .dictionary(dictionary): try container.encode(dictionary)
        }
    }

    // MARK: - Internal

    public var path: Path? {
        switch self {
        case let .file(path):
            return path
        default:
            return nil
        }
    }
}

// MARK: - Entitlements - ExpressibleByStringInterpolation

extension Entitlements: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self = .file(path: .path(value))
    }
}
