import Vapor

extension Container {
    /// Add a flash message to the `Response` of this `Future`.
    ///
    /// - Parameters:
    ///   - type: The type of the flash message (e.g. `.success` or `.error`).
    ///   - message: The message to display.
    /// - Returns: The `Response` with the flash message added.
    public func flash(_ type: Flash.Kind, _ message: String) -> Self {
        if let container: FlashContainer = try? make() {
            container.flashes.append(.init(type, message))
        }
        return self
    }
}
