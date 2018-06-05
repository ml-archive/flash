import Vapor

public struct FlashMiddleware: Middleware, ServiceType {
    private static let sessionKey = "_flash"

    public static func makeService(for container: Container) throws -> FlashMiddleware {
        return .init()
    }

    public init() {}

    /// See Middleware.respond
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        try FlashMiddleware.handle(req: req)
        return try next.respond(to: req)
            .map(to: Response.self) { resp in
                try FlashMiddleware.handle(req: req, resp: resp)
                return resp
            }
    }

    public static func handle(req: Request) throws {
        let session = try req.session()

        if let data = session[sessionKey]?.data(using: .utf8) {
            let flash = try JSONDecoder().decode(FlashContainer.self, from: data)
            let container = try req.privateContainer.make(FlashContainer.self)
            container.new = flash.new
            container.old = flash.old
        }
    }

    public static func handle(req: Request, resp: Response) throws {
        let container = try resp.privateContainer.make(FlashContainer.self)
        let flash = try String(
            data: JSONEncoder().encode(container),
            encoding: .utf8
        )
        try req.session()[sessionKey] = flash
    }
}
