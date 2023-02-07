//
//  MainViewModel.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: MainViewModel {
    var onUpdateView: Driver<Void> {
        base.updateViewsRelay.asDriver(onErrorDriveWith: .empty())
    }

    var onShowError: Driver<APIError> {
        base.showErrorRelay.asDriver(onErrorDriveWith: .empty())
    }
}

typealias AssetDataSource = UICollectionViewDiffableDataSource<AssetItemSection, AnyHashable>
typealias AssetSnapshot = NSDiffableDataSourceSnapshot<AssetItemSection, AnyHashable>

final class MainViewModel: ReactiveCompatible {
    private let disposeBag = DisposeBag()

    // MARK: - Properties
    fileprivate let updateViewsRelay = PublishSubject<Void>()
    fileprivate let showErrorRelay = PublishSubject<APIError>()


    private(set) var assets: [AssetModel] = []

    // MARK: - Initial
    init() {
        fetchAssetData()
    }
}

// MARK: - 🔒 Data source
private extension MainViewModel {
    func fetchAssetData() {
        NetworkManager.getAssets(offset: 0)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let response):
                    owner.assets = response.assets
                    owner.updateViewsRelay.onNext(())

                case .failure(let error):
                    owner.showErrorRelay.onNext(error)
                }
            }).disposed(by: disposeBag)
    }
}
