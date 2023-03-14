//
//  CartCounterView.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit

public class CartCounterView: UIView {
    // MARK: - Subviews
    private let decrementButton = UIButton()
    private let countLabel = UILabel()
    private let incrementButton = UIButton()
    private let footerButton = FloatingButton()

    // MARK: - Public Variables
    public var currentCount: Int = 0 {
        didSet {
            countLabel.text = "\(currentCount)"
        }
    }

    public var onUpdateTapped: (() -> Void)?

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
            $0.backgroundColor = .clear
        }

        with(UIStackView()) {
            addSubview($0)
            $0.spacing = 8

            $0.addArrangedSubview(with(decrementButton) {
                $0.backgroundColor = .systemRed
                $0.layer.cornerRadius = 8
                $0.setTitle("-", for: .normal)
                $0.setTitleColor(.white, for: .normal)
                $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
                $0.addTarget(self, action: #selector(onDecrementTapped), for: .touchUpInside)

                $0.translatesAutoresizingMaskIntoConstraints = false
                let constraint = [
                    $0.heightAnchor.constraint(equalToConstant: 44),
                    $0.widthAnchor.constraint(equalToConstant: 44)
                ]
                NSLayoutConstraint.activate(constraint)
            })

            $0.addArrangedSubview(with(countLabel) {
                $0.textAlignment = .center
                $0.font = UIFont.boldSystemFont(ofSize: 24)
                $0.backgroundColor = .systemGray4
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
                $0.textColor = .black
                $0.text = "\(currentCount)"

                $0.translatesAutoresizingMaskIntoConstraints = false
                let constraint = [
                    $0.heightAnchor.constraint(equalToConstant: 44)
                ]
                NSLayoutConstraint.activate(constraint)
            })

            with(footerButton) {
                addSubview($0)

                $0.onTapped = { [weak self] in
                    self?.onUpdateTapped?()
                }

                $0.translatesAutoresizingMaskIntoConstraints = false
                let constraint = [
                    $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                ]
                NSLayoutConstraint.activate(constraint)
            }

            $0.addArrangedSubview(with(incrementButton) {
                $0.backgroundColor = .systemGreen
                $0.layer.cornerRadius = 8
                $0.setTitle("+", for: .normal)
                $0.setTitleColor(.white, for: .normal)
                $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
                $0.addTarget(self, action: #selector(onIncrementTapped), for: .touchUpInside)

                $0.translatesAutoresizingMaskIntoConstraints = false
                let constraint = [
                    $0.heightAnchor.constraint(equalToConstant: 44),
                    $0.widthAnchor.constraint(equalToConstant: 44)
                ]
                NSLayoutConstraint.activate(constraint)
            })

            $0.translatesAutoresizingMaskIntoConstraints = false
            let constraint = [
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                $0.topAnchor.constraint(equalTo: self.topAnchor),
                $0.bottomAnchor.constraint(equalTo: footerButton.topAnchor, constant: -8),
                $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]
            NSLayoutConstraint.activate(constraint)
        }

    }

    // MARK: - Button actions
    @objc private func onDecrementTapped() {
        if currentCount == 0 { return }
        currentCount -= 1
    }

    @objc private func onIncrementTapped() {
        if currentCount == Int.max { return }
        currentCount += 1
    }

    // MARK: - Configs
    @discardableResult
    public func set(footerButtonTitle: String) -> Self {
        footerButton.set(body: footerButtonTitle)
        return self
    }

    @discardableResult
    public func set(count: Int) -> Self {
        currentCount = count
        return self
    }
}
