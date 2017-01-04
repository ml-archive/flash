import XCTest
@testable import Flash

class FlashTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Flash().text, "Hello, World!")
    }


    static var allTests : [(String, (FlashTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
