//
//  APIService.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation
import Moya

enum APIService {
    case getAssets(address: String, offset: Int, limit: Int)
    case getBalance(address: String)
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .getAssets:
            return URL(string: AppConfig.API.baseURL)!
        case .getBalance:
            return URL(string: AppConfig.API.rpcBaseURL)!
        }
    }

    var path: String {
        switch self {
        case .getAssets:
            return "/api/v1/assets"
        case .getBalance:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBalance:
            return .post
        default:
            return .get
        }
    }

    var headers: [String: String]? { nil }

    var parameters: [String: Any]? {
        switch self {
        case .getAssets(let address, let offset, let limit):
            return [
                "owner": address,
                "offset": offset,
                "limit": limit
            ]
        case .getBalance(let address):
            return [
                "jsonrpc": "2.0",
                "id": 1,
                "method": "eth_getBalance",
                "params": [address, "latest"]
            ]
        }
    }

    var task: Moya.Task {
        guard let parameters = self.parameters else {
            return .requestPlain
        }
        switch method {
        case .get:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        default:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
