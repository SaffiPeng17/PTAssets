//
//  MainViewController.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: MainViewModel

    // MARK: - Subviews
    private let button = UIButton()

    // MARK: - Initial
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 🔒 Private methods
private extension MainViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        button.setTitle("Go Detail", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
}
