import Foundation
import ProjectDescription
import TSCBasic
import struct TuistGraph.Plugins
import TuistSupport
import XCTest

@testable import TuistSupportTesting

final class PlistValueCodableConformanceTests: TuistUnitTestCase {
    
    private struct Person: Decodable {
        struct Birthday: Decodable {
            let day: Int
            let month: Int
        }
        static func plistMockValue() -> [String: Plist.Value] {
            ["name": "John Doe",
             "weight": 75.50,
             "age": 42,
             "isImportant": true,
             "birthday": ["day": 5, "month": 7],
             "nicknames": ["unknown", "mister x", "no idea"]]
        }
        static func jsonMockValue() -> Data {
            """
            {
                "name": "John Doe",
                "weight": 75.50,
                "age": 42,
                "isImportant": true,
                "birthday": { "day": 5, "month": 7 },
                "nicknames": ["unknown", "mister x", "no idea"]
            }
            """.data(using: .utf8) ?? .init()
        }
        
        let name: String
        let age: Int
        let isImportant: Bool
        let weight: Double
        let birthday: Birthday
        let nicknames: [String]
    }
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func validate(_ result: Person, line: UInt = #line) throws {
        
        XCTAssertEqual(result.name, "John Doe", line: line)
        XCTAssertEqual(result.age, 42, line: line)
        XCTAssertEqual(result.weight, 75.5, line: line)
        XCTAssertTrue(result.isImportant, line: line)
        XCTAssertEqual(result.birthday.day, 5, line: line)
        XCTAssertEqual(result.birthday.month, 7, line: line)
        XCTAssertEqual(result.nicknames, ["unknown", "mister x", "no idea"], line: line)
    }
    
    // MARK: - Tests
    
    func test_plist_value_json_encoding() throws {
        // Given
        let plist: Plist.Value = .dictionary(Person.plistMockValue())
        let encodedData = try encoder.encode(plist)

        // When
        let result = try decoder.decode(Person.self, from: encodedData)

        // Then
        try validate(result)
    }
}
