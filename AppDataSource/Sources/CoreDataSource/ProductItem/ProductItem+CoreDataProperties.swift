//
//  ProductItem+CoreDataProperties.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//
//

import Foundation
import CoreData

extension ProductItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItem> {
        return NSFetchRequest<ProductItem>(entityName: EntityName.productItem)
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var price: Double
    @NSManaged public var desc: String
    @NSManaged public var image: String
    @NSManaged public var count: Int32

    func convertToDataObj() -> ProductCoreDataObj {
        ProductCoreDataObj(
            id: id,
            name: name,
            description: desc,
            price: price,
            imageSource: image,
            count: count)
    }
}

extension ProductItem : Identifiable {

}
