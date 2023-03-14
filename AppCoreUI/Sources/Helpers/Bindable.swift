//
//  Bindable.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

/// Used to bind views to view models
/// ```
/// class ViewModel {
///     let title = Bindable<String>("")
/// }
///
/// class ViewController: UIViewController {
///     let viewModel: ViewModel
///     let titleLabel: UILabel
///
///     override func viewDidLoad() {
///         super.viewDidLoad()
///
///         viewModel.title.bind {[weak self] _, newValue in
///             self?.titleLabel.text = newValue
///         }
///     }
/// }
/// ```

public class Bindable<T> {
    public var value: T {
        didSet {
            listener?(oldValue, value)
        }
    }

    private var listener: ((_ oldValue: T, _ newValue: T) -> Void)?

    public init(_ value: T) {
        self.value = value
    }

    public func bind(_ closure: @escaping (_ oldValue: T, _ newValue: T) -> Void) {
        listener = closure
        closure(value, value)
    }
}
