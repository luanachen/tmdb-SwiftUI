import Combine
import Foundation

protocol LoginServiceType {
    func saveUserSession(sessionId: String)
    func getUserSession() -> String?
    func requestToken() -> AnyPublisher<Authentication, Error>
    func loginWithUser(login: LoginModel) -> AnyPublisher<String, Error>
    func requestSession(requestToken: String) -> AnyPublisher<SessionId, Error>
}

class LoginService: LoginServiceType, MoviesDBNetworkClientType {
    let session: URLSession = URLSession.shared

    let sessionStoreManager: SessionStoreManagerType

    init(sessionStoreManager: SessionStoreManagerType = SessionStoreManager()) {
        self.sessionStoreManager = sessionStoreManager
    }

    func saveUserSession(sessionId: String) {
        let data = Data(from: sessionId)
        let _ = sessionStoreManager.save(key: "sessionId", data: data)
    }

    func getUserSession() -> String? {
        let value = sessionStoreManager.load(key: "sessionId")
        return value?.to(type: String.self)
    }

    func requestToken() -> AnyPublisher<Authentication, Error> {
        let endPoint = LoginEndpoint.requestToken
        var request = endPoint.request
        request.httpMethod = HTTPMethodType.get.rawValue

        return Future { seal in
            self.fetch(with: request) { json in
                return json as? Authentication
            } completion: { response in
                switch response {
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
        var request = LoginEndpoint.loginWithUser.postRequest(parameters: login, headers: [])!
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return Future { seal in
            self.fetch(with: request) { json in
                return json as? Authentication
            } completion: { response in
                switch response {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response.requestToken))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func requestSession(requestToken: String) -> AnyPublisher<SessionId, Error> {
        let model = RequestToken(requestToken: requestToken)
        var postRequest = LoginEndpoint.requestSession.postRequest(parameters: model, headers: [])!
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return Future { seal in
            self.fetch(with: postRequest) { json in
                return json as? SessionId
            } completion: { response in
                switch response {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
