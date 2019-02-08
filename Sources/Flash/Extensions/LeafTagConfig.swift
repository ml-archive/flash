import Leaf

public extension LeafTagConfig {
    public mutating func useFlashLeafTags() {
        use(FlashTag(), as: "flash")
    }
}
