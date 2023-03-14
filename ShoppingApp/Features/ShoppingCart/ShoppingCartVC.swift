//
//  ShoppingCartViewController.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit
import AppCoreUI

class ShoppingCartVC: UIViewController {
    // MARK: - Subviews
    private let tableView: UITableView = .default()
    private let cartValuesLabel = UILabel()
    private let footerButton = FloatingButton()

    // MARK: - Variables
    private var cartItems = [ProductView.Model]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - ViewModel
    private let viewModel: ShoppingCartVMProtocol

    // MARK: - Initializers
    init(vm: ShoppingCartVMProtocol) {
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

        with(cartValuesLabel) {
            view.addSubview($0)
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.textColor = .systemGray
            $0.textAlignment = .center
            $0.minimumScaleFactor = 0.5

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.heightAnchor.constraint(equalToConstant: 32)
            ]
            NSLayoutConstraint.activate(constraint)
        }

        with(footerButton) {
            view.addSubview($0)

            $0.set(body: viewModel.footerButtonTitle) { [weak self] in
                self?.confirmCheckout()
            }

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: cartValuesLabel.bottomAnchor, constant: 4),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraint)
        }
    }

    private func bind() {
        viewModel.cartList.bind { [weak self] _, cartList in
            self?.cartItems = cartList
        }
        viewModel.cartValues.bind { [weak self] _, values in
            self?.cartValuesLabel.text = values
        }
        viewModel.footerButtonEnabled.bind { [weak self] _, enable in
            self?.footerButton.set(enabled: enable)
        }
    }

    private func confirmCheckout() {
        let alert = UIAlertController(
            title: viewModel.checkoutAlertTitle,
            message: viewModel.checkoutAlertMessage,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: viewModel.checkoutAlertButtonTitle,
            style: .default
        ) { [weak self]_ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)

        viewModel.confirmCheckout()
        present(alert, animated: true)
    }
}

// MARK: - ShoppingCartVC + UITableViewDelegate + UITableViewDataSource
extension ShoppingCartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ProductView.self, for: indexPath)
        cell.configure(with: .init(model: cartItems[indexPath.row]))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVM = ProductDetailsVM()
        detailsVM.product = cartItems[indexPath.row]
        let detailsVC = ProductDetailsVC(vm: detailsVM)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
