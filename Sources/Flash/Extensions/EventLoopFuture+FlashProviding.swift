import Vapor

public extension EventLoopFuture where Value: Response {
    func flash(_ type: Flash.Kind, _ message: String) -> EventLoopFuture<Response> {
        map { response in
            response.flash(type, message)
        }
    }
}
