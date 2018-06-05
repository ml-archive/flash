import Vapor

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
