import Vapor

public protocol FlashProviding: AnyObject {
    var flashes: [Flash] { get set }
    func flash(_ type: Flash.Kind, _ message: String) -> Self
}

extension FlashProviding {
    @discardableResult
    public func flash(_ type: Flash.Kind, _ message: String) -> Self {
        flashes.append(.init(type, message))

        return self
    }
}

struct FlashStorageKey: StorageKey {
    typealias Value = [Flash]
}
