//
//  LoginServiceTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 19/04/21.
//

import Foundation
import XCTest
@testable import Login

class LoginServiceTests: XCTestCase {

    var sut: LoginService!
    var sessionManagerMock: SessionStoreManagerMock!

    override func setUp() {
        super.setUp()
        sessionManagerMock = SessionStoreManagerMock()
        sut = LoginService(sessionStoreManager: sessionManagerMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_saveUserSession_callsSessionManagerSave() {
        let sessionId = "123"
        sut.saveUserSession(sessionId: sessionId)
        XCTAssertEqual(sessionManagerMock.data, Data(from: sessionId))
    }

    func test_getUserSession_callsSessionManagerLoad() {
        XCTAssertEqual(sut.getUserSession(), "123")
    }

}
