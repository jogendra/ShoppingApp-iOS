//
//  Identifiable.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

public protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    public static var identifier: String {
        return String(describing: self)
    }
}
