//
//  APIService.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation
import Moya

enum APIService {
}

extension APIService: TargetType {
    var baseURL: URL {
    }

    var path: String {
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
