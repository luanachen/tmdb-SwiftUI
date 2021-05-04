//
//  MoviesDB_LuanaApp.swift
//  MoviesDB-Luana
//
//  Created by Luana Chen Chih Jun on 30/03/21.
//

import Commons
import SwiftUI

@main
struct MoviesDB_LuanaApp: App {
    private let coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
