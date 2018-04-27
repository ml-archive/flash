import Async
import Leaf
import TemplateKit

public final class FlashTag: TagRenderer {
    public func render(tag: TagContext) throws -> EventLoopFuture<TemplateData> {
        let body = try tag.requireBody()

        return Future.map(on: tag) { .string("") }
    }

    public init() {}
}
