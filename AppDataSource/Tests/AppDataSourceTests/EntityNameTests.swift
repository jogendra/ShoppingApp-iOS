//
//  EntityNameTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppDataSource

final class EntityNameTests: XCTestCase {

    func testEntityName() throws {
        XCTAssertEqual(EntityName.productItem, "ProductItem")
    }
}
