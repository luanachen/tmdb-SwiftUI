//
//  LoginDemoApp.swift
//  LoginDemo
//
//  Created by Luana on 06/05/21.
//

import Login
import SwiftUI

@main
struct LoginDemoApp: App {
    var body: some Scene {
        WindowGroup {
            LoginCoordinator(delegate: nil).start()
        }
    }
}


