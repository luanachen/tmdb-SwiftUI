//
//  XCTest+extensions.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 15/04/21.
//

import XCTest

extension XCTest {

    func expectToEventually(
        _ isFulfilled: @autoclosure () -> Bool,
        timeout: TimeInterval,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line) {

        func wait() { RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01)) }

        let timeout = Date(timeIntervalSinceNow: timeout)
        func isTimeout() -> Bool { Date() >= timeout }

        repeat {
            if isFulfilled() { return }
            wait()
        } while !isTimeout()

        XCTFail(message, file: file, line: line)
    }
}
