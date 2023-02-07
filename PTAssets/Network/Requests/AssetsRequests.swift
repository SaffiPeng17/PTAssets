//
//  AssetsRequests.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation
import RxSwift

protocol AssetsRequestsProtocol {
    static func getAssets(offset: Int) -> Observable<APIResult<AssetsResponse>>
}

extension NetworkManager: AssetsRequestsProtocol {
    /**
     Fetch assets from API

     - Parameters:
        - offset: which page of data, such as 0 ~ N
     - Returns:
        Return AssetsResponse model
     */
    static func getAssets(offset: Int) -> Observable<APIResult<AssetsResponse>> {
        let address = AppConfig.User.address
        let limit = AppConfig.API.paginationLimit // how much data in one time
        return request(.getAssets(address: address, offset: offset, limit: limit))
    }
}
