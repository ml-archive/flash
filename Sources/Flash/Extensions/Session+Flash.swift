import Vapor

public extension Session {
    private static let flashSessionKey = "_flash"

    var flashes: [Flash] {
        get {
            guard
                let data = data[Self.flashSessionKey]?.data(using: .utf8),
                let flashes = try? JSONDecoder().decode([Flash].self, from: data)
            else {
                return []
            }

            return flashes
        }
        set {
            guard
                let newFlashes = try? String(data: JSONEncoder().encode(newValue), encoding: .utf8)
            else {
                data[Self.flashSessionKey] = nil
                return
            }

            data[Self.flashSessionKey] = newFlashes
        }
    }
}
