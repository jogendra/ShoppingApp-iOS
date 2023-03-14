//
//  ProductDTOTests.swift
//  ShoppingAppTests
//
//  Created by Jogendra on 18/03/2023.
//

import XCTest
@testable import AppDataSource

final class ProductDtoTests: XCTestCase {

    func testProductsListResponse() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "products", withExtension: "json") else {
            XCTFail("Missing file: products.json")
            return
        }

        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode([ProductDTO].self, from: data)

        XCTAssertEqual(response.count, 20)
        XCTAssertEqual(response.first?.name, "La Lorraine Tombul Ekmek")
        XCTAssertEqual(response.first?.price, 7.5)
    }

}
