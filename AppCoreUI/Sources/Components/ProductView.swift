//
//  ProductView.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit

public class ProductView: UIView, Configurable {
    // MARK: - Subviews
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let countLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private Methods
    private func setup() {
        with(self) {
            $0.backgroundColor = .clear
        }

        with(imageView) {
            addSubview($0)
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                $0.heightAnchor.constraint(equalToConstant: 80),
                $0.widthAnchor.constraint(equalToConstant: 80)
            ]
            NSLayoutConstraint.activate(constraint)
        }

        with(UIStackView()) {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 8

            $0.addArrangedSubview(with(nameLabel) {
                $0.numberOfLines = 2
                $0.textAlignment = .left
                $0.textColor = .black
                $0.font = UIFont.boldSystemFont(ofSize: 20)
            })
            $0.addArrangedSubview(with(priceLabel) {
                $0.textAlignment = .left
                $0.textColor = .systemGreen
                $0.font = UIFont.italicSystemFont(ofSize: 18)
            })
            $0.addArrangedSubview(with(countLabel) {
                $0.textAlignment = .left
                $0.textColor = .systemBrown
                $0.font = UIFont.boldSystemFont(ofSize: 18)
                $0.isHidden = true
            })
            $0.addArrangedSubview(with(descriptionLabel) {
                $0.numberOfLines = 3
                $0.textAlignment = .left
                $0.textColor = .systemGray
                $0.font = UIFont.systemFont(ofSize: 16)
            })

            let constraint = [
                $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
                self.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 16),
                self.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 16)
            ]
            NSLayoutConstraint.activate(constraint)
        }
    }

    // MARK: - Configurations
    @discardableResult
    public func set(image: String?) -> Self {
        imageView.loadImage(from: image)
        return self
    }

    @discardableResult
    public func set(name: String?) -> Self {
        nameLabel.text = name
        return self
    }

    @discardableResult
    public func set(price: Double?) -> Self {
        priceLabel.text = "Price: $\(price ?? 0)"
        return self
    }

    @discardableResult
    public func set(description: String?) -> Self {
        descriptionLabel.text = description
        return self
    }

    @discardableResult
    public func set(count: Int) -> Self {
        countLabel.isHidden = count <= 0
        countLabel.text = "Items in cart: \(count)"
        return self
    }
}

// MARK: - ProductView + Configurable
extension ProductView {
    public struct Model {
        public let imageSource: String?
        public let name: String?
        public let price: Double?
        public let description: String?
        public let count: Int

        public init(
            imageSource: String?,
            name: String?,
            price: Double?,
            description: String?,
            count: Int = 0
        ) {
            self.imageSource = imageSource
            self.name = name
            self.price = price
            self.description = description
            self.count = count
        }

        /// Get unique ID associated with object.
        public func getID() -> String {
            guard let first = name?.components(separatedBy: " ").first, let price
            else { return "NoIDObject" }

            return "\(first)\(Int(price))"
        }
    }

    public func configure(with model: Model) {
        set(image: model.imageSource)
        set(name: model.name)
        set(price: model.price)
        set(description: model.description)
        set(count: model.count)
    }

    public func prepareForReuse() {
        set(image: nil)
        set(name: nil)
        set(price: nil)
        set(description: nil)
        set(count: 0)
    }
}
