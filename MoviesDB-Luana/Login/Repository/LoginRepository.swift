import Foundation
import NetworkHelper

class LoginRepository: APIClient {
    var session: URLSession = URLSession.shared

    let sessionStoreManager: SessionStoreManager

    init(sessionStoreManager: SessionStoreManager = SessionStoreManager()) {
        self.sessionStoreManager = sessionStoreManager
    }

    func saveUserSession(requestToken: String) {
        let data = Data(from: requestToken)
        let _ = sessionStoreManager.save(key: "requestToken", data: data)
    }

    func getUserSession() -> String? {
        let value = sessionStoreManager.load(key: "requestToken")
        return value?.to(type: String.self)
    }

    func requestToken(completion: @escaping (Result<Authentication, APIError>) -> Void) {
        let endPoint = LoginEndpoint.requestToken
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

        fetch(with: request, decode: { json in
            guard let result = json as? Authentication else { return nil }
            return result
        }, completion: completion)
    }

    func loginWithUser(login: LoginModel, completion: @escaping (Result<Authentication, APIError>) -> Void) {
        guard var request = LoginEndpoint.loginWithUser.postRequest(parameters: login, headers: []) else { return }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        fetch(with: request, decode: { json in
            guard let result = json as? Authentication else { return nil }
            return result
        }, completion: completion)
    }

    func requestSessionId(requestToken: String, completion: @escaping (Result<SessionId, APIError>) -> Void) {
        let requestToken = RequestToken(requestToken: requestToken)
        guard var request = LoginEndpoint.requestSession.postRequest(parameters: requestToken, headers: []) else { return }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        fetch(with: request, decode: { json in
            guard let result = json as? SessionId else { return nil }
            return result
        }, completion: completion)
    }

}
