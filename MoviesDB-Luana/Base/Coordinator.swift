//
//  Coordinator.swift
//  MoviesDB-Luana
//
//  Created by Luana on 29/04/21.
//

import Commons
import Login
import SwiftUI

class Coordinator: CoordinatorProtocol {
    
    private let sessionManager = SessionStoreManager()
    
    func start() -> AnyView {
        if let _ = sessionManager.load(key: "sessionIdd") {
            return AnyView(ShowsCollectionView())
        } else {
            return startLogin()
        }
    }
    
    // Starts Login flow
    private func startLogin() -> AnyView {
        let coordinator = LoginCoordinator(delegate: self)
        return coordinator.start()
    }
}

extension Coordinator: LoginCoordinatorDelegate {
    func startNextFlow() -> AnyView {
        AnyView(ShowsCollectionView())
    }
}
