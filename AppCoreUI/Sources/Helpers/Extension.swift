//
//  AppCoreUI+Extension.swift
//  
//
//  Created by Jogendra on 18/03/2023.
//

import UIKit

// MARK: - UITableView + Register
extension UITableView {
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.identifier)
    }

    public func register<T: UIView & Configurable>(wrappedViewClass: T.Type) {
        register(cellClass: TableViewCellWrapper<T>.self)
    }

    public func dequeueCell<T: Identifiable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    public func dequeueCell<T: UIView>(_ type: T.Type, for indexPath: IndexPath) -> TableViewCellWrapper<T> {
        return dequeueCell(for: indexPath)
    }
}

// MARK: - UITableView
extension UITableView {
    public static func `default`() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        return tableView
    }
}

// MARK: - UITableViewCell
extension UITableViewCell: Identifiable {}

// MARK: - Double
extension Double {
    public func stringValue() -> String {
        return String(format: "%.2f", self)
    }
}

// MARK: - UIImageView
extension UIImageView {
    public func loadImage(from urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
