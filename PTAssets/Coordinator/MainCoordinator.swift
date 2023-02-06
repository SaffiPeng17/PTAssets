//
//  MainCoordinator.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let factory: MainCoordinatorFactory

    init(navigationController: UINavigationController, factory: MainCoordinatorFactory) {
        self.navigationController = navigationController
        self.factory = factory

    }

    func start() {
        let mainVC = factory.makeMainView()
        mainVC.coordinator = self

        navigationController.viewControllers = [mainVC]
    }

    func showDetailView(asset: AssetModel) {
        let detailVC = factory.makeDetailView(asset: asset)
        detailVC.coordinator = self

        navigationController.pushViewController(detailVC, animated: true)
    }
}
