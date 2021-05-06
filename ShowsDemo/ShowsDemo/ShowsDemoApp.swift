//
//  ShowsDemoApp.swift
//  ShowsDemo
//
//  Created by Luana on 06/05/21.
//

import Shows
import SwiftUI

@main
struct ShowsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ShowsCoordinator(delegate: nil).start()
        }
    }
}
