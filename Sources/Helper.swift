import Vapor
import HTTP

public final class Helper {
    public static let flashKey = "_flash"
    enum State: String {
        case new = "new"
        case old = "old"
    }
    
    public enum FlashType: String {
        case error = "error"
        case success = "success"
        case info = "info"
        case warning = "warning"
    }
    
    private let request: Request
    
    public init(request: Request) {
        self.request = request
    }

    private func foo() {
        return
    }
    
    /// Add a message to a enum key
    ///
    /// - Parameters:
    ///   - type: FlashType
    ///   - message: String message
    /// - Throws: Error
    public func add(_ type: FlashType, _ message: String) throws {
        try request.assertSession().data[Helper.flashKey, State.new.rawValue, type.rawValue] = Node(message)
    }
    
    /// Add a message to a custom key
    ///
    /// - Parameters:
    ///   - custom: String key
    ///   - message: String message
    /// - Throws: Error
    public func add(_ custom: String, _ message: String) throws {
        try request.assertSession().data[Helper.flashKey, State.new.rawValue, custom] = Node(message)
    }
    
    /// Refresh session, move current flash messages to "new" again, 
    /// that means they will be showed on next Request
    ///
    /// - Throws: Error
    public func refresh() throws {
        // Copy old node to new node
        try request.assertSession().data[Helper.flashKey, State.new.rawValue] = try request.assertSession().data[Helper.flashKey, State.old.rawValue] ?? Node([])
    }
    
    /// Clear the session
    ///
    /// - Throws: Error
    public func clear() throws {
        try request.assertSession().data[Helper.flashKey] = nil
        request.storage[Helper.flashKey] = nil
    }
}
