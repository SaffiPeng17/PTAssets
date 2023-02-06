//
//  AssetListCell.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/6.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

extension Reactive where Base: AssetListCell {
    var onTap: Driver<AssetModel> {
        base.tapGesture.rx.event
            .map { _ in base.model }
            .asDriver(onErrorDriveWith: .empty())
    }
}

class AssetListCell: UICollectionViewCell {
    static let cellID = String(describing: AssetListCell.self)

    private(set) var disposeBag = DisposeBag()

    // MARK: - Properties
    fileprivate let tapGesture = UITapGestureRecognizer()
    fileprivate var model: AssetModel!

    // MARK: - Subviews
    private let bgView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()

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

// MARK: - Public methods
extension AssetListCell {
    func configureCell(with model: AssetModel) {
        self.model = model

        imageView.kf.setImage(with: URL(string: model.imageURL),
                              placeholder: #imageLiteral(resourceName: "imageIcon"))

        nameLabel.text = model.name
    }
}

// MARK: - 🔒 Private methods
private extension AssetListCell {
    func setupViews() {
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 4
        bgView.layer.shadowColor = UIColor.darkGray.cgColor
        bgView.layer.shadowOffset = .init(width: 0, height: 0)
        bgView.layer.shadowRadius = 4
        bgView.layer.shadowOpacity = 0.5
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgView.addGestureRecognizer(tapGesture)

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        bgView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(6)
            make.height.equalTo(imageView.snp.width)
        }

        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(6)
        }
    }
}
