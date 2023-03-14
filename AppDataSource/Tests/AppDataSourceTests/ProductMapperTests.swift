//
//  ProductMapperTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppDataSource

final class ProductMapperTests: XCTestCase {

    func testMapProductDTOToProduct() throws {
        let productDTO = ProductDTO(
            name: "Product 1",
            description: "This is the first product",
            price: 9.99,
            imageSource: "product1.png"
        )

        let product = try ProductMapper.map(productDTO)

        XCTAssertEqual(product.id, "Product9")
        XCTAssertEqual(product.name, "Product 1")
        XCTAssertEqual(product.description, "This is the first product")
        XCTAssertEqual(product.price, 9.99)
        XCTAssertEqual(product.imageSource, "product1.png?raw=true")
    }

    func testGenerateID() {
        let name = "Product 2"
        let price = 4.99

        let id = ProductMapper.generateID(name: name, price: price)

        XCTAssertEqual(id, "Product4")
    }

}
