import Commons
import Foundation

enum LoginEndpoint {
    case requestToken
    case loginWithUser
    case requestSession
}

extension LoginEndpoint: MoviesDBEndpointType {
    private var apiKey: String {
        "d26d586dbfdee567a78223358cc2512d"
    }

    var base: String {
        "https://api.themoviedb.org"
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

