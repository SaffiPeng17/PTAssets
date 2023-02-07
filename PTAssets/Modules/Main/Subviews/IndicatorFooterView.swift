//
//  IndicatorFooterView.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/7.
//

import UIKit

class IndicatorFooterView: UICollectionReusableView {

    // MARK: - Subviews
    private let indicatorView = UIActivityIndicatorView()

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
private extension IndicatorFooterView {
    func setupViews() {
        indicatorView.color = .darkGray

        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.top.bottom.equalTo(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(24)
        }

        indicatorView.startAnimating()
    }
}
