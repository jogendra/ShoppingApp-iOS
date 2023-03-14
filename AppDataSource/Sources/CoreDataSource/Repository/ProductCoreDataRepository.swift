//
//  ProductCoreDataRepository.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation
import CoreData

public protocol ProductCoreDataRepositoryProtocol {
    func createOrUpdate(product: ProductCoreDataObj)
    func getAll() -> [ProductCoreDataObj]?
    func getItemCount(for id: String) -> Int
    func getCartTotalAmount() -> Double
    func getCartItemCount() -> Int
    @discardableResult func reset() -> Bool
}

/// Manage all operations on `ProductItem` entity.
public struct ProductCoreDataRepository: ProductCoreDataRepositoryProtocol {

    public init() {}

    /// Create new item in `ProductItem` entiry.
    /// - Parameters:
    ///     - product: Product Core Data Object for values to be inserted.
    public func create(product: ProductCoreDataObj) {
        if product.count <= 0 { return }

        let productRef = ProductItem(context: CoreDataSource.shared.context)
        productRef.id = product.id
        productRef.name = product.name
        productRef.price = product.price
        productRef.desc = product.description
        productRef.image = product.imageSource
        productRef.count = product.count

        CoreDataSource.shared.saveContext()
    }

    /// Create array of new items in `ProductItem` entiry.
    /// If `product` does not exist in CoreData, we create new item in entity.
    /// If `product` already exist and new `count` is `Zero`,  remove it from entity.
    /// If `product` already exist and new `count` is  greater than`Zero`, we update `count`.
    /// - Parameters:
    ///     - product: object needs to be created or updated.
    public func createOrUpdate(product: ProductCoreDataObj) {
        let productItem = getItemBy(id: product.id)

        if let productItem {
            if product.count <= 0 {
                CoreDataSource.shared.context.delete(productItem)
                CoreDataSource.shared.saveContext()
                return
            }
            productItem.count = product.count
            CoreDataSource.shared.saveContext()
        } else {
            create(product: product)
        }
    }

    /// Fetch all the items exist in `ProductItem` entiry.
    /// - Returns: Array of Product Core Data Object.
    public func getAll() -> [ProductCoreDataObj]? {
        let productData = CoreDataSource.shared.fetchManagedObject(managedObject: ProductItem.self)

        var productList = [ProductCoreDataObj]()

        productData?.forEach({ prod in
            productList.append(prod.convertToDataObj())
        })

        return productList
    }

    /// Get total amount of the products in `ProductItem` entiry.
    /// - Returns: total amount.
    public func getCartTotalAmount() -> Double {
        guard let list = getAll() else { return 0 }

        return list.reduce(0, { $0 + ($1.price * Double($1.count)) })
    }

    /// Get total count of the products in `ProductItem` entiry.
    /// - Returns: total count of the products.
    public func getCartItemCount() -> Int {
        guard let list = getAll() else { return 0 }

        return list.reduce(0, { $0 + Int($1.count) })
    }

    /// Get  `count` of certain product in `ProductItem` entiry.
    /// - Parameters:
    ///     - id: product id.
    /// - Returns: total count of the products.
    public func getItemCount(for id: String) -> Int {
        guard let productItem = getItemBy(id: id) else { return 0 }
        return Int(productItem.count)
    }

    /// Delete/Remove all the items in `ProductItem` entiry.
    /// - Returns: `true` if reset operation is successful, otherwise `false`.
    @discardableResult
    public func reset() -> Bool {

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.productItem)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try CoreDataSource.shared.context.execute(deleteRequest)
            CoreDataSource.shared.saveContext()
        } catch {
            return false
        }

        return true
    }

    /// Delete an existing item in `ProductItem` entiry.
    /// - Parameters:
    ///     - id: Data object id which needs to be deleted.
    /// - Returns: `true` if delete operation is successful, otherwise `false`.
    private func delete(id: String) -> Bool {

        guard let productItem = getItemBy(id: id) else { return false }

        CoreDataSource.shared.context.delete(productItem)
        CoreDataSource.shared.saveContext()

        return true
    }

    /// Get an existing item in `ProductItem` entiry.
    /// - Parameters:
    ///     - id: Data object id which needs to be deleted.
    /// - Returns: `ProductItem` correspond to `id`.
    private func getItemBy(id: String) -> ProductItem? {

        let fetchRequest = NSFetchRequest<ProductItem>(entityName: EntityName.productItem)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            let productItem = try CoreDataSource.shared.context.fetch(fetchRequest).first

            return productItem

        } catch let error {
            debugPrint(error)
        }

        return nil
    }
}
