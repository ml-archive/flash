import Vapor

/// A message that can be displayed on a web page. The message is displayed
public struct Flash: Codable {
    public enum Kind: String, Codable {
        case error
        case success
        case info
        case warning
    }

    /// The kind of message.
    /// - See: `Flash.Kind`.
    public let kind: Kind

    /// The message to be displayed.
    public let message: String

    /// Create a new `Flash` message.
    ///
    /// - Parameters:
    ///   - kind: The kind of message.
    ///   - message: The text to be displayed.
    public init(_ kind: Kind, _ message: String) {
        self.kind = kind
        self.message = message
    }
}
