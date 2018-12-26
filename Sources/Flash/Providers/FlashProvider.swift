import Leaf
import Vapor

/// Provider that registers FlashMiddleware and FlashContainer, and FlashTag.
public final class FlashProvider: Provider {

    /// Create a new `FlashProvider`.
    public init() {}

    /// See `Provider.register`.
    public func register(_ services: inout Services) throws {
        services.register(FlashMiddleware.self)
        services.register { container in
            return FlashContainer()
        }
    }

    /// See `Provider.didBoot`
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public extension LeafTagConfig {
    public mutating func useFlashLeafTags() {
        use(FlashTag(), as: "flash")
    }
}
