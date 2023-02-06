//
//  UICollectionView+exteions.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/6.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type,
                                           identifier: String = String(describing: T.self)) {
        register(T.self, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type,
                                                      identifier: String = String(describing: T.self),
                                                      for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("dequeue cell failed with identifier: \(identifier)")
        }
        return cell
    }
}
