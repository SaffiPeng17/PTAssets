//
//  AssetDetailCell.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/6.
//

import UIKit

class AssetDetailCell: UITableViewCell {

    // MARK: - Subviews
    private let bgView = UIView()
    private let assetImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Initial
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public methods
extension AssetDetailCell {
    func configureCell(with asset: AssetModel) {
        assetImageView.kf.setImage(with: URL(string: asset.imageURL),
                                   placeholder: #imageLiteral(resourceName: "imageIcon"))
        nameLabel.text = asset.name
        nameLabel.sizeToFit()

        descriptionLabel.text = asset.description
        descriptionLabel.sizeToFit()
    }
}

// MARK: - 🔒 Private methods
private extension AssetDetailCell {
    func setupViews() {
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        assetImageView.contentMode = .scaleAspectFit
        bgView.addSubview(assetImageView)
        assetImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(assetImageView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(assetImageView)
        }

        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(assetImageView)
            make.bottom.equalToSuperview()
        }
    }
}
