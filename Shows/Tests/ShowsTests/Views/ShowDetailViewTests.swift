//
//  ShowDetailViewTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 20/04/21.
//

@testable import Shows
import SnapshotTesting
import XCTest

class ShowDetailViewTests: XCTestCase {
    func test_snapshot() {
        let preview = ShowDetailView_Previews.previews
        assertSnapshot(matching: preview, as: .image(layout: .device(config: .iPhone8Plus)))
    }
}
