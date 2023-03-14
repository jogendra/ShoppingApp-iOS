//
//  ProductDetailVM.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation
import AppCoreUI
import AppDataSource

protocol ProductDetailsVMProtocol {
    var navigationTitle: String { get }
    var footerButtonTitle: String { get }
    var productsInCart: Bindable<Int> { get set }
    var product: ProductView.Model? { get set }

    func start()
    func updateCart(count: Int, completion: () -> Void)
}

class ProductDetailsVM: ProductDetailsVMProtocol {
    var navigationTitle = "Product Details"
    var footerButtonTitle = "Update Cart"
    var productsInCart: Bindable<Int> = .init(0)
    var product: ProductView.Model?

    private let coreDataRepository: ProductCoreDataRepositoryProtocol

    init(coreDataRepository: ProductCoreDataRepositoryProtocol = ProductCoreDataRepository()) {
        self.coreDataRepository = coreDataRepository
    }

    func start() {
        getItemsInCart()
    }

    func updateCart(count: Int, completion: () -> Void) {
        guard let id = product?.getID(),
            let name = product?.name,
              let description = product?.description,
              let price = product?.price,
              let imageSource = product?.imageSource
        else { return completion() }

        let item = ProductCoreDataObj(
            id: id,
            name: name,
            description: description,
            price: price,
            imageSource: imageSource,
            count: Int32(count))
        coreDataRepository.createOrUpdate(product: item)

        completion()
    }

    private func getItemsInCart() {
        guard let productID = product?.getID() else { return }
        productsInCart.value = coreDataRepository.getItemCount(for: productID)
    }
}
