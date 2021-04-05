import Combine
import Foundation
import NetworkHelper

class LoginRepository: APIClient {
    let session: URLSession = URLSession.shared

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

    func requestToken() -> AnyPublisher<Authentication, Error> {
        Future { seal in
            self.requestToken { result in
                switch result {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func loginWithUser(login: LoginModel) -> AnyPublisher<String, Error> {
        Future { seal in
            self.loginWithUser(login: login) { result in
                switch result {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response.requestToken))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func requestToken(completion: @escaping (Result<Authentication, APIError>) -> Void) {
        let endPoint = LoginEndpoint.requestToken
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

        fetch(with: request, decode: { json in
            guard let result = json as? Authentication else { return nil }
            return result
        }, completion: completion)
    }

    private func loginWithUser(login: LoginModel, completion: @escaping (Result<Authentication, APIError>) -> Void) {
        guard var request = LoginEndpoint.loginWithUser.postRequest(parameters: login, headers: []) else { return }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        fetch(with: request, decode: { json in
            guard let result = json as? Authentication else { return nil }
            return result
        }, completion: completion)
    }
}
