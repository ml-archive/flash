import Vapor

extension SubContainer {
    public func flash(_ type: Flash.Kind, _ message: String) -> SubContainer {
        if let container = try? self.make(FlashContainer.self) {
            container.flashes.append(.init(type, message))
        }
        return self
    }
}
