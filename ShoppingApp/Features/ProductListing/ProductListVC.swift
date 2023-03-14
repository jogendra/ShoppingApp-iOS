//
//  ProductListVC.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit
import AppCoreUI

class ProductListVC: UIViewController {
    // MARK: - Subviews
    private let tableView: UITableView = .default()
    private let cartFooterButton = CartFooterButton()

    // MARK: - Variables
    private var listItems = [ProductView.Model]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - ViewModel
    private let viewModel: ProductListVMProtocol

    // MARK: - Initializers
    init(vm: ProductListVMProtocol) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        viewModel.start()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshCartData()
    }

    // MARK: - Private Methods
    private func setup() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.navigationTitle

        with(view) {
            $0?.backgroundColor = .white
        }

        with(tableView) {
            view.addSubview($0)

            $0.delegate = self
            $0.dataSource = self
            $0.register(wrappedViewClass: ProductView.self)

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
            NSLayoutConstraint.activate(constraint)
        }

        with(cartFooterButton) {
            view.addSubview($0)

            $0.set(count: 4)
            $0.set(amount: 348.9)
            $0.onTapped = { [weak self] in
                self?.showCart()
            }

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraint)
        }
    }

    private func bind() {
        viewModel.productList.bind { [weak self] _, productList in
            self?.listItems = productList
        }
        viewModel.cartItemsCount.bind { [weak self] _, newValue in
            self?.cartFooterButton.set(count: newValue)
            self?.cartFooterButton.set(enabled: newValue > 0)
        }
        viewModel.cartItemsTotalAmount.bind { [weak self] _, newValue in
            self?.cartFooterButton.set(amount: newValue)
        }
    }

    private func showCart() {
        let shoppingVC = ShoppingCartVC(vm: ShoppingCartVM())
        navigationController?.pushViewController(shoppingVC, animated: true)
    }
}

// MARK: - ProductListVC + UITableViewDelegate + UITableViewDataSource
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ProductView.self, for: indexPath)
        cell.configure(with: .init(model: listItems[indexPath.row]))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVM = ProductDetailsVM()
        detailsVM.product = listItems[indexPath.row]
        let detailsVC = ProductDetailsVC(vm: detailsVM)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
