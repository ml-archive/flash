import Vapor

/// Middleware that passes along any flashes from the session to the next incoming request.
public struct FlashMiddleware: Middleware {
    public init() {}
    
    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        // Copy any flashes from the session into the request before responding to it, without overwriting any existing flashes that have been inserted
        request.flashes += request.session.flashes

        return next.respond(to: request).map { response in
            // Copy any flashes from the response to this request back into the session, replacing any existing flashes that are there already
            request.session.flashes = response.flashes

            return response
        }
    }
}
