//
//  ProductDTO.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation


public struct ProductDTO: Decodable {
    let name: String?
    let description: String?
    let price: Double?
    let imageSource: String?

    enum CodingKeys: String, CodingKey {
        case name = "productName"
        case description = "productDescription"
        case price = "productPrice"
        case imageSource = "productImage"
    }
}
