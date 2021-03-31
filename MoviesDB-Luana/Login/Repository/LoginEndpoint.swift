import Foundation
import NetworkHelper

enum LoginEndpoint {
    case requestToken
    case loginWithUser
    case requestSession
}

extension LoginEndpoint: EndpointType {
    private var apiKey: String {
        return "d26d586dbfdee567a78223358cc2512d"
    }

    var base: String {
        return "https://api.themoviedb.org"
    }

    var path: String {
        switch self {
        case .requestToken: return "/3/authentication/token"
        case .loginWithUser: return "/3/authentication/token"
        case .requestSession: return "/3/authentication/session"
        }
    }

    var pathparam: String? {
        switch self {
        case .requestToken, .requestSession:
            return "/new"
        case .loginWithUser:
            return "/validate_with_login"
        }

    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .requestToken, .loginWithUser, .requestSession:
            return [URLQueryItem(name: "api_key", value: apiKey)]
        }
    }

}

