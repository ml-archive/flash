import Leaf

public extension LeafTagConfig {
    mutating func useFlashLeafTags() {
        use(FlashTag(), as: "flash")
    }
}
