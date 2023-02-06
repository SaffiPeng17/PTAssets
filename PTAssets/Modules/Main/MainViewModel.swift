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
    var snapshot: Driver<AssetSnapshot> {
        base.snapshotRelay.asDriver(onErrorDriveWith: .empty())
    }

    var isLoading: Driver<Bool> {
        base.isLoadingRelay.asDriver(onErrorDriveWith: .empty())
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
    fileprivate let snapshotRelay = BehaviorRelay<AssetSnapshot>(value: AssetSnapshot())
    fileprivate let isLoadingRelay = PublishRelay<Bool>()
    fileprivate let showErrorRelay = PublishRelay<APIError>()

    private var currentAssets: [AssetModel] = []

    init() {
        fetchAssetData()
    }
}

// MARK: - 🔒 Private methods
private extension MainViewModel {
    func fetchAssetData() {
        NetworkManager.getAssets(offset: 0)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let response):
                    owner.updateSnapshot(assets: response.assets)
                case .failure(let error):
                    owner.showErrorRelay.accept(error)
                }
            }).disposed(by: disposeBag)
    }

    func updateSnapshot(assets: [AssetModel]) {
        isLoadingRelay.accept(false)

        currentAssets += assets

        let snapshot = makeSnapshot(with: currentAssets)
        snapshotRelay.accept(snapshot)
    }

    func makeSnapshot(with assets: [AssetModel]) -> AssetSnapshot {
        var snapshot = AssetSnapshot()
        snapshot.appendSections(AssetItemSection.allCases)
        snapshot.appendItems(assets, toSection: .asset)

        return snapshot
    }
}
