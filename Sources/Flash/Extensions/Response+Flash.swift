import Vapor

extension Response: FlashProviding {
    public var flashes: [Flash] {
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
