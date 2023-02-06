//
//  MainViewController.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()

    // MARK: - Properties
    weak var coordinator: MainCoordinator?

    private let viewModel: MainViewModel

    // MARK: - Subviews
    private var collectionView: UICollectionView = {
        let itemHorizontalSpacing: CGFloat = 14
        let itemVerticalSpacing: CGFloat = 20
        let contentInset: CGFloat = 16
        let imageTextSpacing: CGFloat = 4
        let textHeight: CGFloat = 30

        var flowLayout: UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = itemHorizontalSpacing
            layout.minimumLineSpacing = itemVerticalSpacing

            let width = (UIScreen.main.bounds.width - contentInset * 2 - itemHorizontalSpacing) / 2
            let height = width + imageTextSpacing + textHeight
            layout.itemSize = .init(width: width, height: height)
            return layout
        }

        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.contentInset = .init(top: contentInset, left: contentInset, bottom: contentInset, right: contentInset)

        return view
    }()

    // MARK: - Initial
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
        setupBinding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 🔒 Private methods
private extension MainViewController {
    func setupViews() {
        title = "Asset List"
        view.backgroundColor = .systemBackground

        collectionView.register(AssetListCell.self, forCellWithReuseIdentifier: AssetListCell.cellID)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }

    func setupBinding() {
        viewModel.rx.onUpdateView
            .drive(onNext: { [weak self] in
                // TODO: reload table
                print("fetch asset success")
            }).disposed(by: disposeBag)

        viewModel.rx.onShowError
            .drive(onNext: { [weak self] error in
                // TODO: show error alert
                print("error =", error)
            }).disposed(by: disposeBag)
    }
}
