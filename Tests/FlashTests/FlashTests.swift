import XCTest
import HTTP
@testable import Flash

class FlashTests: XCTestCase {
    func testMiddleware() {
        let _ = FlashMiddleware()
        
        XCTAssertTrue(true)
    }
    
    func testHelper() throws {
        do {
            let request = try Request(method: .get, uri: "uri")
            let _ = Helper(request: request)
            
            XCTAssertTrue(true)
        } catch {
            print(error)
            
            XCTAssertTrue(false)
        }
    }

    static var allTests : [(String, (FlashTests) -> () throws -> Void)] {
        return [
            ("testMiddleware", testMiddleware),
            ("testHelper", testHelper),
            
        ]
    }
}
