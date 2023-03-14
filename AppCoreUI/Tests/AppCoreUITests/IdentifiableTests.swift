//
//  IdentifiableTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppCoreUI

final class IdentifiableTests: XCTestCase {
    struct TestStruct: Identifiable {}

    class TestClass: Identifiable {}

    func testIdentifier() {
        XCTAssertEqual(TestStruct.identifier, "TestStruct")
        XCTAssertEqual(TestClass.identifier, "TestClass")
    }
}

