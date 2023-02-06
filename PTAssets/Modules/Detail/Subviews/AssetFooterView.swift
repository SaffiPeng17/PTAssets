//
//  AssetFooterView.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/7.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: AssetFooterView {
    var onOpenLink: ControlEvent<Void> {
        base.goButton.rx.tap
    }
}

class AssetFooterView: UIView {

    // MARK: - Subviews
    fileprivate let goButton = UIButton()

    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 🔒 Private methods
private extension AssetFooterView {
    func setupViews() {
        backgroundColor = .white

        goButton.backgroundColor = .systemBlue
        goButton.setTitle("Go Link", for: .normal)
        goButton.setTitleColor(.white, for: .normal)
        goButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        goButton.layer.cornerRadius = 8
        addSubview(goButton)
        goButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(45)
        }
    }
}
