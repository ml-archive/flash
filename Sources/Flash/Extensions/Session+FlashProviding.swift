import Vapor

extension Session: FlashProviding {
    private static let flashSessionKey = "_flash"

    public var flashes: [Flash] {
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
            if let flashData = try? JSONEncoder().encode(newValue) {
                data[Self.flashSessionKey] = String(data: flashData, encoding: .utf8)
            } else {
                data[Self.flashSessionKey] = nil
            }
        }
    }
}
