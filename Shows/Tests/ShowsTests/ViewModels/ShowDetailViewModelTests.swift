//
//  ShowDetailViewModelTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 19/04/21.
//

import Commons
import Foundation
import XCTest
@testable import Shows

class ShowDetailViewModelTests: XCTestCase {

    var sut: ShowDetailViewModel!
    var serviceMock: ShowsServiceMock!

    override func setUp() {
        super.setUp()
        let shows = ResponseLoader.getResponseFrom(resource: "popularTV", decodable: PaginatedResponse<Show>.self)

        serviceMock = ShowsServiceMock()
        sut = ShowDetailViewModel(show: (shows.results?[0])!, service: serviceMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_posterUrl_hasCorrectURL() {
        XCTAssertEqual(sut.posterUrl,
                       URL(string: "https://image.tmdb.org/t/p/w500/vC324sdfcS313vh9QXwijLIHPJp.jpg"))
    }

    func test_fetchShowDetail_isSuccess() {
        sut.fetchShowDetail()

        expectToEventually(sut.lastSeason != nil, timeout: 1)
        expectToEventually(!sut.casts.isEmpty, timeout: 1)
    }

    func test_fetchShowDetail_isFail() {
        serviceMock.isRequestSuccess = false
        sut.fetchShowDetail()

        expectToEventually(sut.lastSeason == nil, timeout: 1)
        expectToEventually(sut.casts.isEmpty, timeout: 1)
    }
}
