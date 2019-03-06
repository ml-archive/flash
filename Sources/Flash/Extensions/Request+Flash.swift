import Vapor

extension Request {
    @discardableResult
    public func flash(_ type: Flash.Kind, _ message: String) -> Request {
        if let container = try? privateContainer.make(FlashContainer.self) {
            container.flashes.append(.init(type, message))
        }
        return self
    }
}
