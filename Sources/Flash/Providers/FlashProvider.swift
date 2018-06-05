import Vapor

extension FlashProvider {
    public static var tags: [String: TagRenderer] {
        return ["flash": FlashTag()]
    }
}

public final class FlashProvider: Provider {
    public init() {}

    public func register(_ services: inout Services) throws {
        services.register(FlashMiddleware.self)
        services.register { container in
            return FlashContainer()
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}
