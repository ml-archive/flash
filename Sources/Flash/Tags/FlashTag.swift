import Leaf
import LeafKit
import Vapor

public struct FlashTag: LeafTag {
    private enum DataKey {
        static let all = "all"
    }

    public init() {}

    public func render(_ ctx: LeafContext) throws -> LeafData {
        guard let request = ctx.request else {
            throw LeafContextError.requestNotPassedToRenderContext
        }

        var dictionary: [String: LeafData] = [
            DataKey.all: request.flashes.leafData
        ]

        for kind in Flash.Kind.allCases {
            dictionary[kind.rawValue] = request.flashes.filter { $0.kind == kind }.leafData
        }

        return .dictionary(dictionary)
    }
}

extension Collection where Element: LeafDataRepresentable {
    var leafData: LeafData {
        .array(compactMap { $0.leafData })
    }
}

extension Flash: LeafDataRepresentable {
    private enum DataKey {
        static let kind = "kind"
        static let bootstrapClass = "bootstrapClass"
        static let message = "message"
    }

    public var leafData: LeafData {
        .dictionary([
            DataKey.kind: .string(kind.rawValue),
            DataKey.bootstrapClass: .string(kind.bootstrapClass),
            DataKey.message: .string(message)
        ])
    }
}

enum LeafContextError: Error {
    case requestNotPassedToRenderContext
}

extension LeafContextError {
    var identifier: String {
        switch self {
            case .requestNotPassedToRenderContext: return "requestNotPassedToRenderContext"
        }
    }

    var reason: String {
        switch self {
            case .requestNotPassedToRenderContext: return "Request not passed into render context."
        }
    }

    var status: HTTPResponseStatus {
        .internalServerError
    }
}

