//
//  LoginViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import Commons
import Combine
import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = false
    @Published var userNameError: String?
    @Published var passwordError: String?
    @Published var requestToken: String?
    @Published var pushActive: Bool = false
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []

    private var service: LoginServiceType

    private var validUserNamePublisher: AnyPublisher<String?, Never> {
        $username
            .removeDuplicates()
            .map { username in
                if username.isEmpty {
                    return "Please enter username"
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }

    private var validPasswordPublisher: AnyPublisher<String?, Never> {
        $password
            .removeDuplicates()
            .map { password in
                if password.isEmpty {
                    return "Please enter password"
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }

    init(service: LoginServiceType = LoginService()) {
        self.service = service
        setupPublishers()
    }

    private func setupPublishers() {
        Publishers.CombineLatest(validUserNamePublisher, validPasswordPublisher)
            .dropFirst()
            .sink { userNameError, passwordError in
                self.isValid = userNameError == nil && passwordError == nil
            }
            .store(in: &cancellableSet)

        validUserNamePublisher
            .dropFirst()
            .sink { userNameError in
                self.userNameError = userNameError
            }
            .store(in: &cancellableSet)

        validPasswordPublisher
            .dropFirst()
            .sink { passwordError in
                self.passwordError = passwordError
            }
            .store(in: &cancellableSet)
    }

    func login() {
        // Request token
        service.requestToken()
            .retry(3)
            .flatMap { [weak self] requestToken -> AnyPublisher<String, Error> in
                guard let self = self else {
                    return Fail(error: MovieDBError.selfNotFound).eraseToAnyPublisher()
                }

                let model = LoginModel(username: self.username, password: self.password, requestToken: requestToken.requestToken)

                // Validate request token with login
                return self.service.loginWithUser(login: model)
            }
            .retry(3)
            .flatMap { [weak self] requestToken -> AnyPublisher<SessionId, Error> in
                guard let self = self else {
                    return Fail(error: MovieDBError.selfNotFound).eraseToAnyPublisher()
                }

                // Request Session id with token
                return self.service.requestSession(requestToken: requestToken)
            }
            .retry(3)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                switch response {
                case .finished:
                    return
                case .failure:
                    self?.showAlert.toggle()
                }
            } receiveValue: { sessionId in
                self.service.saveUserSession(sessionId: sessionId.sessionId)
                self.pushActive.toggle()
            }
            .store(in: &cancellableSet)
    }
}
