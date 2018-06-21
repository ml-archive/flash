import Vapor

/// Container that contains all `Flash`es.
public final class FlashContainer: Codable, Service {
    public var flashes: [Flash] = []
}
