//
//  MainCoordinatorFactory.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/4.
//

import Foundation
import UIKit

protocol MainCoordinatorFactoryProtocol {
    func makeMainViewController() -> MainViewController
}

struct MainCoordinatorFactory: MainCoordinatorFactoryProtocol {

    func makeMainViewController() -> MainViewController {
        let vm = MainViewModel()
        return MainViewController(viewModel: vm)
    }
}
