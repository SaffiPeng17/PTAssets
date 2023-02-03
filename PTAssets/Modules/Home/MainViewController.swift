//
//  MainViewController.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/3.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        label.text = "aaaaaaaaAAAAAAAA"
    }


}

