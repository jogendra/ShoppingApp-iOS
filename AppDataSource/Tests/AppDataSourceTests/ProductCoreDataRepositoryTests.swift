//
//  ProductItemTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
import CoreData
@testable import AppDataSource

class ProductCoreDataRepositoryTests: XCTestCase {
    var repository: ProductCoreDataRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = ProductCoreDataRepository()
        repository.reset()
    }

    override func tearDownWithError() throws {
        repository.reset()
        repository = nil
        try super.tearDownWithError()
    }

    func testCreateOrUpdateProduct() throws {
        // Create Product
        var product = ProductCoreDataObj(
            id: "Test9",
            name: "Test Product",
            description: "Test description",
            price: 9.99,
            imageSource: "test_image.png",
            count: 10)
        repository.createOrUpdate(product: product)

        let products = repository.getAll()
        XCTAssertTrue(products?.count ?? 0 > 0)
        XCTAssertEqual(products?.first?.name, "Test Product")

        // Update Product (count = 0) -> should remove item.
        product = ProductCoreDataObj(
            id: "Test9",
            name: "Test Product",
            description: "Test description",
            price: 9.99,
            imageSource: "test_image.png",
            count: 0)
        repository.createOrUpdate(product: product)
        let updatedList = repository.getAll()
        XCTAssertEqual(products!.count - 1, updatedList!.count)
    }

    func testGetAllProducts() throws {
        let product1 = ProductCoreDataObj(
            id: "Test9",
            name: "Test Product 1",
            description: "Test description 1",
            price: 9.99,
            imageSource: "test_image_1.png",
            count: 2)
        let product2 = ProductCoreDataObj(
            id: "Test19",
            name: "Test Product 2",
            description: "Test description 2",
            price: 19.99,
            imageSource: "test_image_2.png",
            count: 3)
        repository.createOrUpdate(product: product1)
        repository.createOrUpdate(product: product2)

        let products = repository.getAll()
        XCTAssertEqual(products?.count, 2)
    }

    func testGetItemCount() throws {
        let product = ProductCoreDataObj(
            id: "Test9",
            name: "Test Product",
            description: "Test description",
            price: 9.99,
            imageSource: "test_image.png",
            count: 10)
        repository.createOrUpdate(product: product)

        let count = repository.getItemCount(for: "Test9")
        XCTAssertEqual(count, 10)
    }

    func testGetCartTotalAmount() throws {
        let product1 = ProductCoreDataObj(
            id: "Test9",
            name: "Test Product 1",
            description: "Test description 1",
            price: 9.99,
            imageSource: "test_image_1.png",
            count: 2)
        let product2 = ProductCoreDataObj(
            id: "Test19",
            name: "Test Product 2",
            description: "Test description 2",
            price: 19.99,
            imageSource: "test_image_2.png",
            count: 3)
        repository.createOrUpdate(product: product1)
        repository.createOrUpdate(product: product2)

        let totalAmount = repository.getCartTotalAmount()
        XCTAssertEqual(totalAmount, 79.95)
    }

    func testGetCartItemCount() throws {
        let product1 = ProductCoreDataObj(
            id: "Test9",
            name: "Test Product 1",
            description: "Test description 1",
            price: 9.99,
            imageSource: "test_image_1.png",
            count: 2)
        let product2 = ProductCoreDataObj(
            id: "Test19",
            name: "Test Product 2",
            description: "Test description 2",
            price: 19.99,
            imageSource: "test_image_2.png",
            count: 3)
        repository.createOrUpdate(product: product1)
        repository.createOrUpdate(product: product2)

        let count = repository.getCartItemCount()
        XCTAssertEqual(count, 5)
    }

    func testReset() throws {
        repository.reset()
        XCTAssertEqual(repository.getAll()?.count, 0)
    }
}

