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
}

extension APIService: TargetType {
    var baseURL: URL {
        URL(string: AppConfig.API.baseURL)!
    }

    var path: String {
        switch self {
        case .getAssets:
            return "/api/v1/assets"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var headers: [String : String]? { nil }

    var parameters: [String: Any]? {
        switch self {
        case .getAssets(let address, let offset, let limit):
            return ["owner": address,
                    "offset": offset,
                    "limit": limit]
        default:
            return nil
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
