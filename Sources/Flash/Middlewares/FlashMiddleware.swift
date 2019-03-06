import Vapor

public struct FlashMiddleware: Middleware, ServiceType {
    private static let sessionKey = "_flash"

    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    /// See `ServiceType`.
    public static func makeService(for container: Container) throws -> FlashMiddleware {
        return .init()
    }

    public init() {}

    /// See `Middleware`.
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        try handle(req: req)
        return try next.respond(to: req)
            .map(to: Response.self) { resp in
                try self.handle(req: req, resp: resp)
                return resp
            }
    }

    private func handle(req: Request) throws {
        guard let data = try req.session()[FlashMiddleware.sessionKey]?.data(using: .utf8) else { return }

        let flash = try jsonDecoder.decode(FlashContainer.self, from: data)
        let container = try req.privateContainer.make(FlashContainer.self)
        container.new = flash.new
        container.old = flash.old
    }

    private func handle(req: Request, resp: Response) throws {
        let container = try resp.privateContainer.make(FlashContainer.self)
        let flash = try String(
            data: jsonEncoder.encode(container),
            encoding: .utf8
        )
        try req.session()[FlashMiddleware.sessionKey] = flash
    }
}
