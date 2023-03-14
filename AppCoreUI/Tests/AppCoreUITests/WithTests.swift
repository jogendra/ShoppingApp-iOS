//
//  WithTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppCoreUI

final class WithTests: XCTestCase {

    func testWithFunction() {
        let testLabel = UILabel()

        with(testLabel) {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 12
            $0.layer.borderWidth = 2
            $0.text = "Example Text"
        }

        XCTAssertEqual(testLabel.backgroundColor, .black)
        XCTAssertEqual(testLabel.layer.cornerRadius, 12)
        XCTAssertEqual(testLabel.layer.borderWidth, 2)
        XCTAssertEqual(testLabel.text, "Example Text")
    }
}
