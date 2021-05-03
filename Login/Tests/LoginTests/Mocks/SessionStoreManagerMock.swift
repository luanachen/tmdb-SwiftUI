//
//  SessionStoreManagerMock.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 19/04/21.
//

import Commons
import Foundation
@testable import Login

class SessionStoreManagerMock: SessionStoreManagerType {
    var didCallSave = false
    var didCallLoad = false
    var data = Data()

    func save(key: String, data: Data) -> OSStatus {
        didCallSave = true
        self.data = data
        return OSStatus()
    }

    func load(key: String) -> Data? {
        didCallLoad = true
        return Data(from: "123")
    }
}
