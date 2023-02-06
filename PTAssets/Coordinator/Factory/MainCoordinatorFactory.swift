//
//  MainCoordinatorFactory.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/4.
//

import Foundation
import UIKit

protocol MainCoordinatorFactoryProtocol {
    func makeMainView() -> MainViewController
    func makeDetailView(asset: AssetModel) -> DetailViewController
}

struct MainCoordinatorFactory: MainCoordinatorFactoryProtocol {

    func makeMainView() -> MainViewController {
        let vm = MainViewModel()
        return MainViewController(viewModel: vm)
    }

    func makeDetailView(asset: AssetModel) -> DetailViewController {
        let vm = DetailViewModel(asset: asset)
        return DetailViewController(viewModel: vm)
    }
}
