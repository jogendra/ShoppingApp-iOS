//
//  Product.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public struct Product {
    public let id: String // To keep track of items in CoreData and Cart
    public let name: String
    public let description: String
    public let price: Double
    public let imageSource: String

    /// Get unique ID associated with object.
    public func getID() -> String {
        guard let first = name.components(separatedBy: " ").first
        else { return "NoIDObject" }

        return "\(first)\(Int(price))"
    }
}
