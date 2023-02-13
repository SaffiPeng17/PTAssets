//
//  BalanceModel.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/7.
//

import Foundation
import ObjectMapper
import BigInt

struct BalanceModel: Mappable {
    var jsonrpc = ""
    var id = 0
    var result = ""

    init?(map: ObjectMapper.Map) {}

    mutating func mapping(map: ObjectMapper.Map) {
        jsonrpc <- map["jsonrpc"]
        id <- map["id"]
        result <- map["result"]
    }
}

extension BalanceModel {
    var balance: String {
        var hexString = result

        // remove prefix "0x"
        if hexString.hasPrefix("0x") {
            hexString = String(hexString.dropFirst(2))
        }

        // parse hexString to expect balance string
        let bigIntString = BigInt(hexString, radix: 16)?.description
        return bigIntString ?? "--"
    }
}
