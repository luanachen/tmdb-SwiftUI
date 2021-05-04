//
//  LoginViewModelTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 15/04/21.
//

import Combine
import XCTest
@testable import Login

class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!
    var serviceMock: LoginServiceMock!

    override func setUp() {
        super.setUp()
        serviceMock = LoginServiceMock()
        sut = LoginViewModel(service: serviceMock)
    }

    override func tearDown() {
        sut = nil
        serviceMock = nil
        super.tearDown()
    }

    func test_isValid_whenSetValidUsernameAndPassword() {
        sut.username = "foo"
        sut.password = "123"

        XCTAssertTrue(sut.isValid)
    }

    func test_isValid_whenSetInvalidUsernameAndPassword() {
        sut.username = ""
        sut.password = ""

        XCTAssertFalse(sut.isValid)
    }

    func test_login_isSuccess() {
        sut.login()

        expectToEventually(sut.pushActive == true, timeout: 1)
    }

    func test_login_isFailure() {
        serviceMock.isRequestSuccess = false
        sut.login()

        expectToEventually(sut.pushActive == false, timeout: 1)
        expectToEventually(sut.showAlert == true, timeout: 1)
    }

}
