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

    let onLoadMore = PublishSubject<Void>()

    private(set) var assets: [AssetModel] = []

    // for protect not request API more than once
    private var isDataLoading = false

    // MARK: - Initial
    init() {
        getAssetData()
        setupBinding()
    }

    private func setupBinding() {
        onLoadMore
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard !owner.isDataLoading else { return }
                owner.isDataLoading = true
                owner.getAssetData()
            }).disposed(by: disposeBag)
    }
}

// MARK: - 🔒 Data source
private extension MainViewModel {
    func getAssetData() {
        isDataLoading = true

        let nextPage = assets.count / AppConfig.API.paginationLimit
        fetchAssetData(offset: nextPage)
    }

    func fetchAssetData(offset: Int) {
        NetworkManager.getAssets(offset: offset)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let response):
                    owner.assets += response.assets
                    owner.updateViewsRelay.onNext(())

                case .failure(let error):
                    owner.showErrorRelay.onNext(error)
                }
                owner.isDataLoading = false
            }).disposed(by: disposeBag)
    }
}
