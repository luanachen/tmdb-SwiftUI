//
//  MoviesDB_LuanaApp.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import SwiftUI

@main
struct MoviesDB_LuanaApp: App {
    private var sessionManager = SessionStoreManager()

    var body: some Scene {
        WindowGroup {
            if let _ = sessionManager.load(key: "requestToken") {
                ShowsCollectionView()
            } else {
                LoginView()
            }
        }
    }
}
