//
//  BalanceRequests.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/8.
//

import Foundation

protocol BalanceRequestsProtocol {
    static func getBalance() -> Observable<APIResult<BalanceModel>>
}

extension NetworkManager: BalanceRequestsProtocol {
    /**
     Fetch assets from API

     - Returns:
        Return balance model
     */
    static func getBalance() -> Observable<APIResult<BalanceModel>> {
        let address = AppConfig.User.address
        return request(.getBalance(address: address))
    }
}
