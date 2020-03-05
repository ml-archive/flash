import Vapor

public extension Request {
    @discardableResult
    func flash(_ type: Flash.Kind, _ message: String) -> Request {
        flashes.append(.init(type, message))

        return self
    }

    var flashes: [Flash] {
        get {
            if let existing = storage[FlashStorageKey.self] {
                return existing
            } else {
                let new = FlashStorageKey.Value()
                storage[FlashStorageKey.self] = new
                return new
            }
        }
        set {
            storage[FlashStorageKey.self] = newValue
        }
    }
}
