import Vapor

public extension Response {
    func flash(_ type: Flash.Kind, _ message: String) -> Response {
        if let container = try? privateContainer.make(FlashContainer.self) {
            container.flashes.append(.init(type, message))
        }
        return self
    }
}
