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

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public extension LeafTagConfig {
    public mutating func useFlashLeafTags() {
        use(FlashTag(), as: "flash")
    }
}
