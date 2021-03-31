//
//  LoginViewModel.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = false
    @Published var userNameError: String?
    @Published var passwordError: String?

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
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

    private var validUserNamePublisher: AnyPublisher<String?, Never> {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
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
            .debounce(for: 0.5, scheduler: RunLoop.main)
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

    func login() {
        print("Login")
    }
}
