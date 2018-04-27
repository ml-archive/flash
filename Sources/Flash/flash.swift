import Service
import Vapor

extension FlashProvider {
    public static var tags: [String: TagRenderer] {
        return ["flash": FlashTag()]
    }
}

public final class FlashProvider: Provider {
    public init() {}
    
    public func register(_ services: inout Services) throws {
        services.register { container in
            return FlashContainer()
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public final class Flash: Codable {
    public var type: FlashType
    public var message: String

    public init(type: FlashType, message: String) {
        self.type = type
        self.message = message
    }

    public init(_ type: FlashType, _ message: String) {
        self.type = type
        self.message = message
    }
}

public final class FlashContainer: Codable, Service {
    public var new: [Flash] = []
    public var old: [Flash] = []

    public var flashes: [Flash] {
        get {
            return new
        }

        set {
            new = newValue
        }
    }
}

public enum FlashType: String, Codable {
    case error
    case success
    case info
    case warning
}

extension Response {
    public func flash(_ type: FlashType, _ message: String) -> Response {
        if let container = try? privateContainer.make(FlashContainer.self) {
            container.flashes.append(.init(type, message))
        }

        return self
    }
}

public struct FlashMiddleware: Middleware {
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

        if let data = session["_flash"]?.data(using: .utf8) {
            print(String(data: data, encoding: .utf8))
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
        try req.session()["_flash"] = flash
    }
}
