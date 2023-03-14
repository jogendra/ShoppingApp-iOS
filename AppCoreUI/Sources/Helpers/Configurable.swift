//
//  Configurable.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
    func prepareForReuse()
}

public extension Configurable {
    func prepareForReuse() {}
}
