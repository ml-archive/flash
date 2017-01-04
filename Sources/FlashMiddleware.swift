import Vapor
import HTTP
import Auth

public class FlashMiddleware: Middleware {
    public init() {}
    
    /// response
    ///
    /// - Parameters:
    ///   - request: Response
    ///   - next: Responder
    /// - Returns: Response
    /// - Throws: Error
    public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
       
        try FlashMiddleware.handleRequest(request)
        
        // Make request
        let response = try next.respond(to: request)
        
        try FlashMiddleware.handleResponse(response, request)
        
        return response
    }
    
    /// Take flash session and apply to storage, while moving new to old
    ///
    /// - Parameter request: Request
    /// - Throws: Error
    public static func handleRequest(_ request: Request) throws {
        // Init flash node
        let requestFlash = try request.session().data[Helper.flashKey, Helper.State.new.rawValue] ?? Node([])
        
        // Copy new node to old node
        try request.session().data[Helper.flashKey, Helper.State.old.rawValue] = requestFlash
        
        // Apply new node to request storage
        request.storage[Helper.flashKey] = requestFlash
        
        // Clear new node
        try request.session().data[Helper.flashKey, Helper.State.new.rawValue] = nil
    }
    
    /// Retrieve flash storage from response and add it to session
    ///
    /// - Parameters:
    ///   - response: Response
    ///   - request: Request
    /// - Throws: Error
    public static func handleResponse(_ response: Response, _ request: Request) throws {
        // Retreive flash
        guard let flash: Node = response.storage[Helper.flashKey] as? Node else {
            return
        }
        
        // Consider making next 4 ifs more flexible
        if let error: String = flash[Helper.FlashType.error.rawValue]?.string {
            try request.flash.add(.error, error)
        }
        
        if let success: String = flash[Helper.FlashType.success.rawValue]?.string {
            try request.flash.add(.success, success)
        }
        
        if let info: String = flash[Helper.FlashType.info.rawValue]?.string {
            try request.flash.add(.info, info)
        }
        
        if let warning: String = flash[Helper.FlashType.warning.rawValue]?.string {
            try request.flash.add(.warning, warning)
        }
    }
}

