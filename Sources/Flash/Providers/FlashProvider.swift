import Leaf
import Sugar
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
        let tags: MutableLeafTagConfig = try container.make()
        tags.use(FlashTag(), as: "flash")

        return .done(on: container)
    }
}
