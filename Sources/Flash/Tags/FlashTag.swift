import Leaf
import TemplateKit

/// Tag that
public final class FlashTag: TagRenderer {
    /// Create a new `FlashTag`.
    public init() {}

    /// See `TagRenderer.render`.
    public func render(tag: TagContext) throws -> Future<TemplateData> {
        let body = try tag.requireBody()
        let flash: FlashContainer = try tag.container.make()

        guard !flash.flashes.isEmpty else {
            return tag.future(.null)
        }

        var flashes =
            try Dictionary(grouping: flash.flashes) { flash in
                flash.kind.groupingKey
            }
            .mapValues { flashes -> TemplateData in
                .array(try flashes.map { flash in
                    try flash.convertToTemplateData()
                })
            }
        flashes["all"] = .array(try flash.flashes.map { flash in try flash.convertToTemplateData() })

        let existing = (tag.context.data.dictionary ?? [:])
        tag.context.data = .dictionary(
            existing.merging(flashes) { (existing, fromFlash) -> TemplateData in
                return fromFlash
            }
        )

        return tag.serializer.serialize(ast: body).map { view in
            .string(String(data: view.data, encoding: .utf8) ?? "")
        }
    }
}

extension Flash: TemplateDataRepresentable {
    /// See `TemplateDataRepresentable`.
    public func convertToTemplateData() throws -> TemplateData {
        return .dictionary([
            "kind": .string(kind.rawValue),
            "bootstrapClass": .string(kind.rawValue),
            "message": .string(message)
        ])
    }
}

extension Flash.Kind {
    var groupingKey: String {
        switch self {
        case .error: return "errors"
        case .info: return "information"
        case .success: return "successes"
        case .warning: return "warnings"
        }
    }
}
