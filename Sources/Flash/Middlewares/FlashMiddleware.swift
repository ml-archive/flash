import Vapor

/// Middleware that passes along any flashes from the session to the next incoming request.
public struct FlashMiddleware: Middleware {
    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        handle(request: request)

        return next.respond(to: request).map { response in
            self.handle(request: request, response: response)

            return response
        }
    }

    private func handle(request: Request) {
        request.flashes.removeAll()
        request.flashes += request.session.flashes
    }

    private func handle(request: Request, response: Response) {
        request.session.flashes = request.flashes
    }
}
