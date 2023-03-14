//
//  ProductMapper.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

struct ProductMapper: Mapper {
    typealias Input = ProductDTO
    typealias Output = Product

    static func map(_ input: ProductDTO) throws -> Product {
        Product(
            id: generateID(name: input.name, price: input.price),
            name: input.name ?? "",
            description: input.description ?? "",
            price: input.price ?? 0.0,
            imageSource: "\(input.imageSource ?? "")?raw=true")
    }

    // Generate unique ID to each object, later to use for CoreData and Cart
    static func generateID(name: String?, price: Double?) -> String {
        guard let first = name?.components(separatedBy: " ").first,
              let price = price
        else { return "NoIDObject" }

        return "\(first)\(Int(price))"
    }
}
