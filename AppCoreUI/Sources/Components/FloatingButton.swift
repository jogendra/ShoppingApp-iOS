//
//  FloatingButton.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit

public class FloatingButton: UIButton {
    // MARK: - Public Properties
    public var onTapped: (() -> Void)?

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private Methods
    private func setup() {
        with(self) {
            $0.titleLabel?.numberOfLines = 2
            $0.titleLabel?.lineBreakMode = .byTruncatingTail
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 8

            $0.addTarget(self, action: #selector(_onTapped(_:)), for: .touchUpInside)

            let constraint = [
                self.heightAnchor.constraint(equalToConstant: 48)
            ]
            NSLayoutConstraint.activate(constraint)
        }
    }

    @objc func _onTapped(_ sender: UIButton) {
        onTapped?()
    }

    // MARK: - Public Methods
    @discardableResult
    public func set(body: String, completion: (() -> Void)?) -> Self {
        setTitle(body, for: .normal)
        onTapped = completion
        return self
    }

    @discardableResult
    public func set(body: String) -> Self {
        setTitle(body, for: .normal)
        return self
    }

    @discardableResult
    public func set(enabled: Bool) -> Self {
        isEnabled = enabled
        layer.opacity = enabled ? 1.0 : 0.2
        return self
    }
}

