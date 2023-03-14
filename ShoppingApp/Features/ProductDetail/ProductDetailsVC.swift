//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit
import AppCoreUI

class ProductDetailsVC: UIViewController {
    // MARK: - Subviews
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let cartUpdateView = CartCounterView()

    // MARK: - ViewModel
    private let viewModel: ProductDetailsVMProtocol

    // MARK: - Initializers
    init(vm: ProductDetailsVMProtocol) {
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

    // MARK: - Private Methods
    private func setup() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.navigationTitle

        with(view) {
            $0?.backgroundColor = .white
        }

        with(imageView) {
            view.addSubview($0)
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                $0.heightAnchor.constraint(equalToConstant: 200)
            ]
            NSLayoutConstraint.activate(constraint)
        }

        with(UIStackView()) {
            view.addSubview($0)
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 16

            $0.addArrangedSubview(with(nameLabel) {
                $0.numberOfLines = 0
                $0.textAlignment = .left
                $0.textColor = .black
                $0.font = UIFont.boldSystemFont(ofSize: 24)
            })
            $0.addArrangedSubview(with(priceLabel) {
                $0.textAlignment = .left
                $0.textColor = .systemGreen
                $0.font = UIFont.italicSystemFont(ofSize: 22)
            })
            $0.addArrangedSubview(with(descriptionLabel) {
                $0.numberOfLines = 0
                $0.textAlignment = .left
                $0.textColor = .systemGray
                $0.font = UIFont.systemFont(ofSize: 20)
            })

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
            ]
            NSLayoutConstraint.activate(constraint)
        }

        with(cartUpdateView) {
            view.addSubview($0)
            $0.set(footerButtonTitle: viewModel.footerButtonTitle)
            $0.onUpdateTapped = { [weak self] in
                self?.updateCart()
            }

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraint)
        }
    }

    private func bind() {
        imageView.loadImage(from: viewModel.product?.imageSource)
        nameLabel.text = viewModel.product?.name
        priceLabel.text = "Price Per Item: $\(viewModel.product?.price ?? 0)"
        descriptionLabel.text = viewModel.product?.description

        viewModel.productsInCart.bind { [weak self] _, itemCount in
            self?.cartUpdateView.set(count: itemCount)
        }
    }

    private func updateCart() {
        viewModel.updateCart(count: cartUpdateView.currentCount) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
