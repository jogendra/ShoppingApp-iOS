//
//  ProductCoreDataObjTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppDataSource

final class ProductCoreDataObjTests: XCTestCase {
    func testProductCoreDataObjInitialization() {
        let product = ProductCoreDataObj(
            id: "Product9",
            name: "Product 1",
            description: "This is the first product",
            price: 9.99,
            imageSource: "product1.png",
            count: 10)

        XCTAssertEqual(product.id, "Product9")
        XCTAssertEqual(product.name, "Product 1")
        XCTAssertEqual(product.description, "This is the first product")
        XCTAssertEqual(product.price, 9.99)
        XCTAssertEqual(product.imageSource, "product1.png")
        XCTAssertEqual(product.count, 10)
    }
}
