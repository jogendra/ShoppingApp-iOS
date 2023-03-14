//
//  ProductListVM.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit
import AppCoreUI
import AppDataSource

protocol ProductListVMProtocol {
    var navigationTitle: String { get }
    var cartItemsCount: Bindable<Int> { get }
    var cartItemsTotalAmount: Bindable<Double> { get }
    var productList: Bindable<[ProductView.Model]> { get set }
    func start()
    func refreshCartData()
}

class ProductListVM: ProductListVMProtocol {
    var navigationTitle = "Products List"
    var cartItemsCount: Bindable<Int> = .init(0)
    var cartItemsTotalAmount: Bindable<Double> = .init(0.0)
    var productList: Bindable<[ProductView.Model]> = .init([])

    private let repository: ProductRepositoryProtocol
    private let coreDataRepository: ProductCoreDataRepositoryProtocol

    init(
        repository: ProductRepositoryProtocol = ProductRepository(),
        coreDataRepository: ProductCoreDataRepositoryProtocol = ProductCoreDataRepository()
    ) {
        self.repository = repository
        self.coreDataRepository = coreDataRepository
    }

    func start() {
        fetchProductsList()
        fetchCartData()
    }

    func refreshCartData() {
        fetchCartData()
    }

    private func fetchProductsList() {
        repository.getProductList { [weak self] result in
            let products = try? result.get()
            guard let products, let self else { return }

            self.productList.value = products.map {
                ProductView.Model(
                    imageSource: $0.imageSource,
                    name: $0.name,
                    price: $0.price,
                    description: $0.description)
            }
        }
    }

    private func fetchCartData() {
        cartItemsCount.value = coreDataRepository.getCartItemCount()
        cartItemsTotalAmount.value = coreDataRepository.getCartTotalAmount()
    }
}
