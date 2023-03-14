//
//  CartFooterButton.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit

public class CartFooterButton: UIView {
    // MARK: - Subviews
    private let countLabel = UILabel()
    private let amountLabel = UILabel()

    // MARK: - Public Properties
    public var onTapped: (() -> Void)?

    // MARK: - Intializers
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
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 8
            $0.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(_onTapped))
            $0.addGestureRecognizer(tap)

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                self.heightAnchor.constraint(equalToConstant: 48)
            ]
            NSLayoutConstraint.activate(constraint)
        }

        with(UIStackView()) {
            addSubview($0)
            $0.spacing = 16
            $0.alignment = .center

            $0.addArrangedSubview(with(countLabel) {
                $0.numberOfLines = 1
                $0.textAlignment = .center
                $0.font = UIFont.boldSystemFont(ofSize: 20)
                $0.textColor = .red
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
                $0.translatesAutoresizingMaskIntoConstraints = false
                let constraint = [
                    $0.heightAnchor.constraint(equalToConstant: 32),
                    $0.widthAnchor.constraint(equalToConstant: 32)
                ]
                NSLayoutConstraint.activate(constraint)
            })
            $0.addArrangedSubview(with(amountLabel) {
                $0.numberOfLines = 1
                $0.textAlignment = .left
                $0.font = UIFont.boldSystemFont(ofSize: 16)
                $0.textColor = .white
            })

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
                $0.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ]
            NSLayoutConstraint.activate(constraint)
        }
    }

    // MARK: - Button Action
    @objc private func _onTapped() {
        onTapped?()
    }

    // MARK: - Configs
    @discardableResult
    public func set(amount: Double) -> Self {
        amountLabel.text = "Total: $\(amount.stringValue())"
        return self
    }

    @discardableResult
    public func set(count: Int) -> Self {
        countLabel.text = "\(count)"
        return self
    }

    @discardableResult
    public func set(enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        self.layer.opacity = enabled ? 1.0 : 0.2
        return self
    }
}
