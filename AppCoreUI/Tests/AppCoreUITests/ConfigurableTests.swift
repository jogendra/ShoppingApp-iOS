//
//  ConfigurableTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppCoreUI

class TestConfigurable: Configurable {
    var configuredModel: String?

    func configure(with model: String) {
        configuredModel = model
    }

    func prepareForReuse() {
        configuredModel = nil
    }
}

final class ConfigurableTests: XCTestCase {
    func testConfigurable() {
        let configurable = TestConfigurable()
        let model = "TestModel"

        configurable.configure(with: model)

        XCTAssertEqual(configurable.configuredModel, model)

        configurable.prepareForReuse()

        XCTAssertNil(configurable.configuredModel)
    }
}
