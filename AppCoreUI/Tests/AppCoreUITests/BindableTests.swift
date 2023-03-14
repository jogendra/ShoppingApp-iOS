//
//  BindableTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppCoreUI

final class BindableTests: XCTestCase {

    func testBindShouldExecuteClosure() {
        let bindable = Bindable("Initial value")
        var executed = false

        bindable.bind { _, _ in
            executed = true
        }

        XCTAssertTrue(executed)
    }

    func testBindShouldPassOldAndNewValue() {
        let bindable = Bindable("Initial value")
        var oldValue: String?
        var newValue: String?

        bindable.bind { old, new in
            oldValue = old
            newValue = new
        }
        bindable.value = "New value"

        XCTAssertEqual(oldValue, "Initial value")
        XCTAssertEqual(newValue, "New value")
    }

    func testBindShouldExecuteMultipleClosures() {
        let bindable = Bindable("Initial value")
        var closure1Executed = false
        var closure2Executed = false

        bindable.bind { _, _ in
            closure1Executed = true
        }

        bindable.bind { _, _ in
            closure2Executed = true
        }

        XCTAssertTrue(closure1Executed)
        XCTAssertTrue(closure2Executed)
    }
}


