import Leaf
import Sugar
import TemplateKit

public final class FlashTag: TagRenderer {
    public func render(tag: TagContext) throws -> Future<TemplateData> {
        let body = try tag.requireBody()
        let request = try tag.requireRequest()
        let flash = try request.privateContainer.make(FlashContainer.self)

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

        return tag.serializer.serialize(ast: body).map(to: TemplateData.self) { er in
            let body = String(data: er.data, encoding: .utf8) ?? ""
            return .string(body)
        }
    }

    public init() {}
}

extension Flash: TemplateDataRepresentable {
    public func convertToTemplateData() throws -> TemplateData {
        return TemplateData.dictionary([
            "kind": .string(self.kind.rawValue),
            "bootstrapClass": .string(self.kind.bootstrapClass),
            "message": .string(self.message)
        ])
    }
}

extension Flash.Kind {
    var bootstrapClass: String {
        switch self {
        case .error: return "danger"
        case .warning: return "warning"
        case .success: return "success"
        case .info: return "info"
        }
    }
}
