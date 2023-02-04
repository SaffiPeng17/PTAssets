//
//  Coordinator.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/4.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
