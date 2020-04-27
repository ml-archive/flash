import Vapor

public extension EventLoopFuture where Value: Response {
    func flash(_ type: Flash.Kind, _ message: String) -> EventLoopFuture<Response> {
        return map { response in
            response.flash(type, message)
        }
    }
}
