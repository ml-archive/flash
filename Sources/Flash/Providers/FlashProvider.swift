import Leaf
import Sugar
import Vapor

/// Provider that registers FlashMiddleware and FlashContainer, and FlashTag.
public final class FlashProvider: Provider {

    /// Create a new `FlashProvider`.
    public init() {}

    /// See `Provider.register`.
    public func register(_ services: inout Services) throws {
        try services.register(MutableLeafTagConfigProvider())
        services.register(FlashMiddleware.self)
        services.register { container in
            return FlashContainer()
        }
    }

    /// See `Provider.didBoot`
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        let tags: MutableLeafTagConfig = try container.make()
        tags.use(FlashTag(), as: "flash")

        return .done(on: container)
    }
}
