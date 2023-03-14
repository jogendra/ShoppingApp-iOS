//
//  ExtensionTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppCoreUI

final class ExtensionTests: XCTestCase {
    func testStringValue() {
        let value1: Double = 3.14159
        let value2: Double = 24
        let value3: Double = 0.123456789

        let string1 = value1.stringValue()
        let string2 = value2.stringValue()
        let string3 = value3.stringValue()

        XCTAssertEqual(string1, "3.14")
        XCTAssertEqual(string2, "24.00")
        XCTAssertEqual(string3, "0.12")
    }

    func testLoadImage() {
        let imageView = UIImageView()
        imageView.loadImage(from: "https://github.com/android-getir/public-files/blob/main/images/5f36a28b29d3b131b9d95548_tr_1637858193743.jpeg?raw=true")
        XCTAssertNil(imageView.image)
        let expectation = XCTestExpectation(description: "Image loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(imageView.image)
    }
}
