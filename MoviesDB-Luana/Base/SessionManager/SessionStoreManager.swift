//
//  SessionStoreManager.swift
//  ApplaudoTest_Luana
//
//  Created by Luana Chen Chih Jun on 10/03/21.
//

import Foundation

class SessionStoreManager {

    func saveUserSession(requestToken: String) {
        UserDefaults.standard.setValue(requestToken, forKey: "requestToken")
    }

    func getUserSession() -> String? {
        return UserDefaults.standard.object(forKey: "requestToken") as? String
    }
}
