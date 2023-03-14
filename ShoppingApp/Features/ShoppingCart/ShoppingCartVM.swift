//
//  ShoppingCartVM.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation
import AppCoreUI
import AppDataSource

protocol ShoppingCartVMProtocol {
    var navigationTitle: String { get }
    var checkoutAlertTitle: String { get }
    var checkoutAlertMessage: String { get }
    var checkoutAlertButtonTitle: String { get }
    var footerButtonTitle: String { get }
    var cartList: Bindable<[ProductView.Model]> { get set }
    var cartValues: Bindable<String> { get }
    var footerButtonEnabled: Bindable<Bool> { get }
    func start()
    func refreshCartData()
    func confirmCheckout()
}

class ShoppingCartVM: ShoppingCartVMProtocol {
    var navigationTitle = "Shopping Cart"
    var footerButtonTitle = "Checkout"
    var checkoutAlertTitle = "Checkout Completed"
    var checkoutAlertMessage = "Total Items: 0\nTotal Cart Value: $0.0"
    var checkoutAlertButtonTitle = "Okay"
    var cartList: Bindable<[ProductView.Model]> = .init([])
    var cartValues: Bindable<String> = .init("Total Items: 0 & Total Cart Value: $0.0")
    var footerButtonEnabled: Bindable<Bool> = .init(false)

    private let coreDataRepository: ProductCoreDataRepositoryProtocol

    init(coreDataRepository: ProductCoreDataRepositoryProtocol = ProductCoreDataRepository()) {
        self.coreDataRepository = coreDataRepository
    }

    func start() {
        getItemsInCart()
    }

    func refreshCartData() {
        getItemsInCart()
    }

    func confirmCheckout() {
        coreDataRepository.reset()
        cartList.value = []
    }

    private func getItemsInCart() {
        let cartItems = coreDataRepository.getAll()?
            .compactMap {
                ProductView.Model(
                    imageSource: $0.imageSource,
                    name: $0.name,
                    price: $0.price,
                    description: $0.description,
                    count: Int($0.count))}
        cartList.value = cartItems ?? []

        let itemCount = coreDataRepository.getCartItemCount()
        let totalAmount = coreDataRepository.getCartTotalAmount().stringValue()
        footerButtonEnabled.value = itemCount > 0
        cartValues.value = "Total Items: \(itemCount) & Total Cart Value: $\(totalAmount)"
        checkoutAlertMessage = "Total Items: \(itemCount)\nTotal Cart Value: $\(totalAmount)"
    }
}
