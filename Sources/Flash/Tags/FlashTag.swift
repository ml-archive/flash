import Leaf
import Sugar
import TemplateKit

public final class FlashTag {
    public init() {}
}

// MARK: - TagRenderer

extension FlashTag: TagRenderer {
    public func render(tag: TagContext) throws -> Future<TemplateData> {
        let body = try tag.requireBody()
        let request = try tag.requireRequest()
        let flash: FlashContainer = try request.privateContainer.make()

        guard !flash.flashes.isEmpty else {
           return tag.future(.string(""))
        }

        var dict = tag.context.data.dictionary ?? [:]
        dict["all"] = try .array(flash.flashes.map {
            try $0.convertToTemplateData()
        })

        dict["errors"] = try .array(flash.flashes.compactMap { flash in
            guard flash.kind == .error else { return nil }
            return try flash.convertToTemplateData()
        })

        dict["warnings"] = try .array(flash.flashes.compactMap { flash in
            guard flash.kind == .warning else { return nil }
            return try flash.convertToTemplateData()
        })

        dict["successes"] = try .array(flash.flashes.compactMap { flash in
            guard flash.kind == .success else { return nil }
            return try flash.convertToTemplateData()
        })

        dict["information"] = try .array(flash.flashes.compactMap { flash in
            guard flash.kind == .info else { return nil }
            return try flash.convertToTemplateData()
        })

        tag.context.data = .dictionary(dict)

        return tag.serializer.serialize(ast: body).map { view in
            let body = String(data: view.data, encoding: .utf8) ?? ""
            return .string(body)
        }
    }
}

// MARK: - TemplateDataRepresentable

extension Flash: TemplateDataRepresentable {
    public func convertToTemplateData() throws -> TemplateData {
        return .dictionary([
            "kind": .string(kind.rawValue),
            "bootstrapClass": .string(kind.bootstrapClass),
            "message": .string(message)
        ])
    }
}
