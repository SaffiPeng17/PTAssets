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

            // item size
            let itemWidth = (UIScreen.main.bounds.width - contentInset * 2 - itemHorizontalSpacing) / 2
            let itemHeight = itemWidth + imageTextSpacing + textHeight
            layout.itemSize = .init(width: itemWidth, height: itemHeight)

            // footer size
            let footerWidth = itemWidth * 2 + itemHorizontalSpacing
            layout.footerReferenceSize = .init(width: footerWidth, height: 48)

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

    // MARK: - Setup back item style of navigation bar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = ""
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationItem.backButtonTitle = ""
    }
}

// MARK: - 🔒 Private methods
private extension MainViewController {
    func setupViews() {
        title = "Asset List"
        view.backgroundColor = .systemBackground

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AssetListCell.self)
        collectionView.register(IndicatorFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "footer")

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }

    func setupBinding() {
        viewModel.rx.onUpdateView
            .drive(onNext: { [weak self] in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.rx.onShowError
            .drive(onNext: { [weak self] error in
                // TODO: show error alert
                print("error =", error)
            }).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item < viewModel.assets.count else {
            return UICollectionViewCell()
        }

        let asset = viewModel.assets[indexPath.item]
        let cell = collectionView.dequeueReusableCell(AssetListCell.self, for: indexPath)
        cell.configureCell(with: asset)

        cell.rx.onTap
            .drive(onNext: { [weak self] model in
                self?.coordinator?.showDetailView(asset: model)
            }).disposed(by: cell.disposeBag)

        return cell
    }

    // Setup footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: "footer",
                                                               for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == UICollectionView.elementKindSectionFooter else {
            return
        }
        viewModel.onLoadMore.onNext(())
    }
}
