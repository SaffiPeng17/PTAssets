//
//  BalanceHeaderView.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/7.
//

import UIKit
import RxSwift

class BalanceHeaderView: UICollectionReusableView {
    private(set) var disposeBag = DisposeBag()

    // MARK: - Subviews
    private let titleLabel = UILabel()
    let valueLabel = UILabel()

    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

// MARK: - 🔒 Private methods
private extension BalanceHeaderView {
    func setupViews() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.text = "Balance :"

        valueLabel.font = .systemFont(ofSize: 18)
        valueLabel.textColor = .black

        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
