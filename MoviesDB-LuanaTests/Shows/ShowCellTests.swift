//
//  ShowCellTests.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 20/04/21.
//

@testable import MoviesDB_Luana
import SnapshotTesting
import XCTest

class ShowCellTests: XCTestCase {
    func test_Snapshot() {
        let preview = ShowCell_Previews.previews
        assertSnapshot(matching: preview, as: .image(layout: .fixed(width: 175, height: 350)))
    }
}
