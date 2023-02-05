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
        base.onFetchSuccessd.asDriver(onErrorDriveWith: .empty())
    }

    var onShowError: Driver<APIError> {
        base.onFetchFailed.asDriver(onErrorDriveWith: .empty())
    }
}

final class MainViewModel: ReactiveCompatible {
    private let disposeBag = DisposeBag()

    // MARK: - Properties
    fileprivate let onFetchSuccessd = PublishRelay<Void>()
    fileprivate let onFetchFailed = PublishRelay<APIError>()

    private(set) var assets: [AssetModel] = []

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
                    owner.assets = response.assets
                    owner.onFetchSuccessd.accept(())
                case .failure(let error):
                    owner.onFetchFailed.accept(error)
                }
            }).disposed(by: disposeBag)
    }
}
