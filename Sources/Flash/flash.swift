import Service
import Vapor

public final class FlashProvider: Provider {
    public func register(_ services: inout Services) throws {
        services.register { container in
            return FlashContainer()
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public final class FlashContainer: Service {
    public var flashes: [(type: FlashType, message: String)] = []
}

public enum FlashType {

}

extension Response {
    public func flash(_ type: FlashType, _ message: String) -> Response {
        if let container = try? privateContainer.make(FlashContainer.self) {
            container.flashes.append((type, message))
        }

        return self
    }
}
