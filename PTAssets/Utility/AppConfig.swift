//
//  AppConfig.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation

enum AppConfig {

    // MARK: - API
    enum API {
        static let baseURL = "https://testnets-api.opensea.io"
        static let paginationLimit = 20

        static let rpcBaseURL = "https://rpc.ankr.com/eth"
    }

    // MARK: - User
    enum User {
        static let address = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
    }
}
