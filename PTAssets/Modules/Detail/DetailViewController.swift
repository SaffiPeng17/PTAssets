//
//  DetailViewController.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import UIKit

final class DetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    private let viewModel: DetailViewModel

    private let label = UILabel()

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 🔒 Private methods
private extension DetailViewController {
    func setupViews() {
        title = viewModel.asset.collectionName

        view.backgroundColor = .systemBackground
        
        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        label.text = "I am Detail!!!!"
    }
}
