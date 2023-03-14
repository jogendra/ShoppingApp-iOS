//
//  With.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation

/// A function used to encapsulate item specific code
/// - Parameters:
///   - item: Any Item that needs to be configured
///   - closure: A closure where you can configure the item
/// - Returns: Item
///
/// Example:
/// with(view) {
///   $0.backgroundColor = .white
///   $0.layer.cornerRadius = 12
/// }
@discardableResult
public func with<Item>(_ item: Item, _ closure: (Item) -> Void) -> Item {
    closure(item)
    return item
}
