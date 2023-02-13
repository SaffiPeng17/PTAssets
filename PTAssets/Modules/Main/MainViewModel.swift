//
//  MainViewModel.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ReactiveCompatible {
    private let disposeBag = DisposeBag()

    // MARK: In & Out control
    struct Input {
        let onLoadMore: AnyObserver<Void>
    }

    struct Output {
        let onReloadData: Driver<Void>
        let onShowError: Driver<APIError>
        let balance: Observable<String>
    }

    private let loadMoreSubject = PublishSubject<Void>()
    private let reloadDataSubject = PublishSubject<Void>()
    private let showErrorSubject = PublishSubject<APIError>()
    private let balanceRelay = BehaviorRelay<String>(value: "--")

    let input: Input
    let output: Output

    // MARK: - Properties
    private(set) var assets: [AssetModel] = []
    private var isDataLoading = false // for protect not request API more than once

    // MARK: - Initial
    init() {
        input = Input(onLoadMore: loadMoreSubject.asObserver())

        output = Output(onReloadData: reloadDataSubject.asDriver(onErrorDriveWith: .empty()),
                        onShowError: showErrorSubject.asDriver(onErrorDriveWith: .empty()),
                        balance: balanceRelay.asObservable())

        getAssetData()
        getBalance()
        setupBinding()
    }
}

// MARK: - 🔒 Setups
private extension MainViewModel {
    func setupBinding() {
        loadMoreSubject
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard !owner.isDataLoading else { return }
                owner.getAssetData()
            }).disposed(by: disposeBag)
    }
}

// MARK: - 🔒 Asset data source
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
                    owner.reloadDataSubject.onNext(())

                case .failure(let error):
                    owner.showErrorSubject.onNext(error)
                }
                owner.isDataLoading = false
            }).disposed(by: disposeBag)
    }
}

// MARK: - 🔒 Balance data source
private extension MainViewModel {
    func getBalance() {
        NetworkManager.getBalance()
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    guard data.error == nil else {
                        owner.balanceRelay.accept("--")
                        return
                    }
                    owner.balanceRelay.accept(data.balance)

                case .failure(let error):
                    owner.showErrorSubject.onNext(error)
                }

            }).disposed(by: disposeBag)
    }
}
