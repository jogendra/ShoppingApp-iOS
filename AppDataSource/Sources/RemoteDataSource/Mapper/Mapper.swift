//
//  Mapper.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output

    static func map(_ input: Input) throws -> Output
    static func map(_ input: Input?) throws -> Output?
    static func map(_ inputs: [Input]) throws -> [Output]
    static func map(_ inputs: [Input]?) throws -> [Output]
}

extension Mapper {
    static func map(_ input: Input?) throws -> Output? {
        try input.map { try map($0) }
    }

    static func map(_ inputs: [Input]) throws -> [Output] {
        try inputs.map { try map($0) }
    }

    static func map(_ inputs: [Input]?) throws -> [Output] {
        try map(inputs ?? [])
    }
}

enum MappingError: Error {
    case fatal
}
