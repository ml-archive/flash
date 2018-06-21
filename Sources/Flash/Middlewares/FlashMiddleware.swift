import Vapor

/// Middleware that:
/// - decodes flashes from the `Session` and puts them on the `Request`s container.
/// - encodes flashes from the `Response` to the `Session`.
public struct FlashMiddleware: Middleware, ServiceType {
    /// See `ServiceType.makeService`.
    public static func makeService(for container: Container) throws -> FlashMiddleware {
        return .init()
    }

    /// Create a new `FlashMiddleware`.
    public init() {}

    /// See Middleware.respond
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        try req.decodeFlashDataFromSession()
        return try next
            .respond(to: req)
            .try { resp in
                try req.encodeFlashDataToSession(from: resp)
            }
    }
}

private let sessionKey = "_flash"

extension Request {
    func decodeFlashDataFromSession() throws {
        let container = try privateContainer.make(FlashContainer.self)

        guard let data = try session()[sessionKey]?.data(using: .utf8) else {
            container.flashes = []
            return
        }

        let decoded = try JSONDecoder().decode(FlashContainer.self, from: data)
        container.flashes = decoded.flashes
    }

    func encodeFlashDataToSession(from resp: Response) throws {
        let container = try resp.privateContainer.make(FlashContainer.self)
        let flash = try String(
            data: JSONEncoder().encode(container),
            encoding: .utf8
        )
        try session()[sessionKey] = flash
    }
}
