import Vapor

public extension Future where T == Response {
    /// Add a flash message to the `Response` of this `Future`.
    ///
    /// - Parameters:
    ///   - type: The type of the flash message (e.g. `.success` or `.error`).
    ///   - message: The message to display.
    /// - Returns: A `Future` containing the `Response` with the added flash message.
    public func flash(_ type: Flash.Kind, _ message: String) -> Future<Response> {
        return map { response in
            response.flash(type, message)
        }
    }
}
