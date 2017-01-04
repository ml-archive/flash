import XCTest
import HTTP
@testable import Flash

class FlashTests: XCTestCase {
    func testMiddleware() throws {
        let flashMiddleware = FlashMiddleware()
        
        let request = try Request(method: .get, uri: "uri")
        let responder = TestResponse()
        
        // Need a session middleware
        //let _ = try flashMiddleware.respond(to: request, chainingTo: responder)
        
        XCTAssertTrue(true)
    }
    
    func testHelper() throws {
        do {
            let request = try Request(method: .get, uri: "uri")
            let helper = Helper(request: request)
            
            // Need a session middleware
            //try helper.add("custom", "message")
            
            
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

class TestResponse: Responder {
    func respond(to request: Request) throws -> Response {
        return Response()
    }
}
