//
//  ProductModelTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppDataSource

final class ProductModelTests: XCTestCase {

    func testProductCoreDataObjInitialization() {
        let product = Product(
            id: "Test8",
            name: "Test product",
            description: "Lorem Ipsum",
            price: 8.47,
            imageSource: "https://example.png")

        XCTAssertEqual(product.id, "Test8")
        XCTAssertEqual(product.name, "Test product")
        XCTAssertEqual(product.description, "Lorem Ipsum")
        XCTAssertEqual(product.price, 8.47)
        XCTAssertEqual(product.imageSource, "https://example.png")
    }

    func testProductGetID() throws {
        let product = Product(
            id: "Test8",
            name: "Test product",
            description: "Lorem Ipsum",
            price: 8.47,
            imageSource: "https://example.png")
        XCTAssertEqual(product.id, product.getID())
    }
}
