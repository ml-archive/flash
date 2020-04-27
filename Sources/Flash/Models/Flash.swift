import Vapor

public final class Flash: Codable {
    public enum Kind: String, CaseIterable, Codable {
        case error
        case success
        case info
        case warning
    }

    public var kind: Kind
    public var message: String

    public init(kind: Kind, message: String) {
        self.kind = kind
        self.message = message
    }

    public init(_ kind: Kind, _ message: String) {
        self.kind = kind
        self.message = message
    }
}

extension Flash.Kind {
    var bootstrapClass: String {
        switch self {
            case .error: return "danger"
            case .warning: return "warning"
            case .success: return "success"
            case .info: return "info"
        }
    }
}
