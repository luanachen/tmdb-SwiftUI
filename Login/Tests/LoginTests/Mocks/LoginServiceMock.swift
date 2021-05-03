//
//  LoginServiceMock.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 15/04/21.
//

import Commons
import Combine
@testable import Login

class LoginServiceMock: LoginServiceType {
    let requestTokenResponse = ResponseLoader.getResponseFrom(resource: "requestToken", decodable: Authentication.self)
    let sessionResponse = ResponseLoader.getResponseFrom(resource: "createSession", decodable: SessionId.self)

    var isRequestSuccess = true
    var didCallSaveUserSession = false
    var sessionId = ""

    func saveUserSession(sessionId: String) {
        didCallSaveUserSession = true
    }

    func getUserSession() -> String? {
        "123"
    }

    func requestToken() -> AnyPublisher<Authentication, Error> {
        return Future { seal in
            if self.isRequestSuccess {
                seal(.success(self.requestTokenResponse))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

    func loginWithUser(login: LoginModel) -> AnyPublisher<String, Error> {
        return Future { seal in
            if self.isRequestSuccess {
                seal(.success("123"))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

    func requestSession(requestToken: String) -> AnyPublisher<SessionId, Error> {
        return Future { seal in
            if self.isRequestSuccess {
                seal(.success(self.sessionResponse))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }
}
