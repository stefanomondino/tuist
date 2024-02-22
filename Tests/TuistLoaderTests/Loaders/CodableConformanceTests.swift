import Foundation
import ProjectDescription
import TSCBasic
import struct TuistGraph.Plugins
import TuistSupport
import XCTest

@testable import TuistCoreTesting
@testable import TuistLoader
@testable import TuistLoaderTesting
@testable import TuistSupportTesting

final class CodableConformanceTests: TuistUnitTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func test_plist_value_json_encoding() throws {
        // Given
        let plist: ProjectDescription.Plist.Value = .dictionary(["someString": "hello!", "someNumber": 1])
        let encodedData = try encoder.encode(plist)
        struct Stub: Decodable {
            let someString: String
            let someNumber: Double
        }
        // When
        
        let result = try decoder.decode(Stub.self, from: encodedData)

        // Then
        XCTAssertEqual(result.someNumber, 1)
        XCTAssertEqual(result.someString, "hello!")
    }
    
    func test_entitlements_json_encoding() throws {
        // Given
        let plist: ProjectDescription.Entitlements = .dictionary(["someString": "hello!", "someNumber": 1])
        let encodedData = try encoder.encode(plist)
        struct Stub: Decodable {
            let someString: String
            let someNumber: Double
        }
        // When
        
        let result = try decoder.decode(Stub.self, from: encodedData)

        // Then
        XCTAssertEqual(result.someNumber, 1)
        XCTAssertEqual(result.someString, "hello!")
    }
}
