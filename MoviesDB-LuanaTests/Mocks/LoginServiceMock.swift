//
//  LoginServiceMock.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 15/04/21.
//

import Combine
@testable import MoviesDB_Luana

class LoginServiceMock: LoginServiceType {
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
                seal(.success(Authentication(success: true,
                                             expiresAt: "01/01",
                                             requestToken: "123")))
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
                seal(.success(SessionId(success: true, sessionId: "123")))
            } else {
                seal(.failure(MovieDBError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }
}
