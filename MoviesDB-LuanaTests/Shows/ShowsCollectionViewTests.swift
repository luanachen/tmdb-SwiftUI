//
//  ShowsCollectionViewTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 20/04/21.
//

@testable import MoviesDB_Luana
import SnapshotTesting
import XCTest

class ShowsCollectionViewTests: XCTestCase {
    func test_snapshot() {
        let preview = ShowsCollectionView_Previews.previews
        assertSnapshot(matching: preview, as: .image(layout: .device(config: .iPhone8)))
    }
}
