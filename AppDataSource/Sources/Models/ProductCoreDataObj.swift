//
//  ProductCoreDataObj.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public struct ProductCoreDataObj {
    public let id: String
    public let name: String
    public let description: String
    public let price: Double
    public let imageSource: String
    public let count: Int32

    public init(
        id: String,
        name: String,
        description: String,
        price: Double,
        imageSource: String,
        count: Int32
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageSource = imageSource
        self.count = count
    }
}
