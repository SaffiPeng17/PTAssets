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
    private let button = UIButton()

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
        title = "List"

        view.backgroundColor = .systemBackground

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        button.setTitle("Go Detail", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }

    func setupBinding() {
        button.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.coordinator?.showDetailView()
            }).disposed(by: disposeBag)
    }
}
