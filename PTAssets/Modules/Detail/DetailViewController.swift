//
//  DetailViewController.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController {
    private let disposeBag = DisposeBag()

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private let viewModel: DetailViewModel

    // MARK: - Subviews
    private let footerView = AssetFooterView()
    private var contentView: UITableView = {
        let view = UITableView()
        view.contentInset = .init(top: 16, left: 0, bottom: 20, right: 0)
        view.separatorStyle = .none
        view.estimatedRowHeight = UITableView.automaticDimension
        view.allowsSelection = false
        view.contentInsetAdjustmentBehavior = .always
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    // MARK: - Initial
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
        setupBinding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AssetDetailCell.self, for: indexPath)
        cell.configureCell(with: viewModel.asset)
        return cell
    }
}

// MARK: - 🔒 Private methods
private extension DetailViewController {
    func setupViews() {
        title = viewModel.asset.collectionName

        view.backgroundColor = .systemBackground

        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.dataSource = self
        contentView.delegate = self
        contentView.register(AssetDetailCell.self)

        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
    }

    func setupBinding() {
        footerView.rx.onOpenLink
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let permaLink = self.viewModel.asset.permalink
                if let url = URL(string: permaLink) {
                    UIApplication.shared.open(url)
                }
            }).disposed(by: disposeBag)
    }
}
