import Foundation

struct LoginModel: Encodable {
    let username: String
    let password: String
    let requestToken: String
}

struct Authentication: Decodable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
}

struct SessionId: Decodable {
    let success: Bool
    let sessionId: String
}

struct RequestToken: Encodable {
    let requestToken: String
}
