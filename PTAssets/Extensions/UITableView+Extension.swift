//
//  UITableView+Extension.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/6.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type,
                                      identifier: String = String(describing: T.self)) {
        register(T.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type,
                                                 identifier: String = String(describing: T.self),
                                                 for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("dequeue cell failed with identifier: \(identifier)")
        }
        return cell
    }
}
