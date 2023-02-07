//
//  UICollectionView+exteions.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/6.
//

import UIKit

// MARK: - Register/Dequeue customized cell
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

// MARK: - Register/Dequeue customized resuable header and footer
extension UICollectionView {

    enum ReusableViewType {
        case header, footer

        var kind: String {
            switch self {
            case .header: return UICollectionView.elementKindSectionHeader
            case .footer: return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    func register<T: UICollectionReusableView>(_ type: T.Type,
                                               reusableViewType resuableType: ReusableViewType,
                                               identifier: String = String(describing: T.self)) {
        register(T.self, forSupplementaryViewOfKind: resuableType.kind, withReuseIdentifier: identifier)
    }

    func dequeueReusableView<T: UICollectionReusableView>(_ type: T.Type,
                                                          reusableViewType resuableType: ReusableViewType,
                                                          identifier: String = String(describing: T.self),
                                                          indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: resuableType.kind,
                                                                  withReuseIdentifier: identifier,
                                                                  for: indexPath) as? T else {
            fatalError("dequeue reusable view failed with identifier: \(identifier)")
        }
        return reusableView
    }
}
