//
//  Coordinator.swift
//  MoviesDB-Luana
//
//  Created by Luana on 29/04/21.
//

import Commons
import Login
import Shows
import SwiftUI

class Coordinator: CoordinatorProtocol {
    
    private let sessionManager = SessionStoreManager()
    
    func start() -> AnyView {
        if let _ = sessionManager.load(key: "sessionId") {
            return startShows()
        } else {
            return startLogin()
        }
    }
    
    // Starts Login flow
    private func startLogin() -> AnyView {
        let coordinator = LoginCoordinator(delegate: self)
        return coordinator.start()
    }
    
    // Starts Shows flow
    private func startShows() -> AnyView {
        let coordinator = ShowsCoordinator(delegate: nil)
        return coordinator.start()
    }
}

extension Coordinator: LoginCoordinatorDelegate {
    func startNextFlow() -> AnyView {
        startShows()
    }
}
