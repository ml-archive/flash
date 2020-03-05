import Vapor

internal struct FlashStorageKey: StorageKey {
    typealias Value = [Flash]
}
