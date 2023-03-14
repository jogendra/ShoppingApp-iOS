//
//  MapperTests.swift
//  
//
//  Created by Jogendra on 19/03/2023.
//

import XCTest
@testable import AppDataSource

final class MapperTests: XCTestCase {

    struct InputStruct {
        let id: Int
        let name: String
    }

    struct OutputStruct {
        let id: String
        let name: String
    }

    enum MappingError: Error {
        case invalidInput
    }

    struct TestMapper: Mapper {
        typealias Input = InputStruct
        typealias Output = OutputStruct

        static func map(_ input: Input) throws -> Output {
            guard input.id >= 0 else {
                throw MappingError.invalidInput
            }
            return Output(id: "\(input.id)", name: input.name.uppercased())
        }
    }

    func testMapSingleInput() throws {
        let input = InputStruct(id: 1, name: "Test")
        let output = try TestMapper.map(input)

        XCTAssertEqual(output.id, "1")
        XCTAssertEqual(output.name, "TEST")
    }

    func testMapSingleNilInput() throws {
        let input: InputStruct? = nil
        let output = try TestMapper.map(input)

        XCTAssertNil(output)
    }

    func testMapMultipleInputs() throws {
        let inputs = [
            InputStruct(id: 1, name: "Test1"),
            InputStruct(id: 2, name: "Test2"),
            InputStruct(id: 3, name: "Test3")
        ]
        let outputs = try TestMapper.map(inputs)

        XCTAssertEqual(outputs.count, 3)
        XCTAssertEqual(outputs[0].id, "1")
        XCTAssertEqual(outputs[0].name, "TEST1")
        XCTAssertEqual(outputs[1].id, "2")
        XCTAssertEqual(outputs[1].name, "TEST2")
        XCTAssertEqual(outputs[2].id, "3")
        XCTAssertEqual(outputs[2].name, "TEST3")
    }

    func testMapMultipleNilInputs() throws {
        let inputs: [InputStruct]? = nil
        let outputs = try TestMapper.map(inputs)

        XCTAssertEqual(outputs.count, 0)
    }

}

