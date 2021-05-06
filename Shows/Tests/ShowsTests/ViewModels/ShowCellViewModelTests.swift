//
//  ShowCellViewModelTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 19/04/21.
//

import Commons
import Foundation
import XCTest
@testable import Shows

class ShowCellViewModelTests: XCTestCase {

    var sut: ShowCellViewModel!

    override func setUp() {
        super.setUp()
        let shows = ResponseLoader.getResponseFrom(resource: "popularTV", decodable: PaginatedResponse<Show>.self)
        sut = ShowCellViewModel(show: (shows.results?[0])!)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_init_hasCorrectSetup() {
        XCTAssertNotNil(sut.id)
    }

    func test_url_hasCorrectUrl() {
        XCTAssertEqual(sut.url,
                       URL(string: "https://image.tmdb.org/t/p/w500/vC324sdfcS313vh9QXwijLIHPJp.jpg"))
    }
}
