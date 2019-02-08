import Leaf
import Vapor

public final class FlashProvider: Provider {
    public init() {}

    public func register(_ services: inout Services) throws {
        services.register(FlashMiddleware.self)
        services.register { container in
            return FlashContainer()
        }
    }

    public func didBoot(_ container: Container) throws -> Future<Void> {
        return .done(on: container)
    }
}
