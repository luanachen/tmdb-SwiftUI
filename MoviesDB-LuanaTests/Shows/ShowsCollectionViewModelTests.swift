//
//  ShowsCollectionViewModelTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 16/04/21.
//

import Combine
import XCTest
@testable import MoviesDB_Luana

class ShowsCollectionViewModelTests: XCTestCase {

    var sut: ShowsCollectionViewModel!
    var serviceMock: ShowsServiceMock!

    override func setUp() {
        super.setUp()
        serviceMock = ShowsServiceMock()
        sut = ShowsCollectionViewModel(service: serviceMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_segmentedControlItems_returnsCorrectNumberOfItems() {
        XCTAssertEqual(sut.segmentedControlItems.count, 4)
    }

    func test_onChangePickerView_resetsCurrentPage() {
        sut.onAppearProgressView()
        sut.onChangePickerView(value: .airingToday)

        XCTAssertEqual(sut.currentPage, 1)
    }

    func test_onAppearProgressView_increasesCurrentPage() {
        sut.onAppearProgressView()

        XCTAssertEqual(sut.currentPage, 2)
    }

    func test_fetchShows_isSuccess() {
        sut.fetchShows(for: .popular)

        expectToEventually(sut.cellViewModels.count > 0,
                           timeout: 1)
    }

    func test_fetchShows_isFailure() {
        serviceMock.isRequestSuccess = false
        sut.fetchShows(for: .popular)

        expectToEventually(sut.cellViewModels.count == 0,
                           timeout: 1)
        expectToEventually(sut.isShowingAlert, timeout: 1)
    }
}
