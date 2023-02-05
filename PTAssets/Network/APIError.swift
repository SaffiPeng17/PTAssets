//
//  APIError.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation
import Moya

struct APIError: LocalizedError {

    enum ErrorType {
        case mapJsonFailed
        case emptyData
        case responseFailed
    }

    let title = "Error"
    private(set) var message: String

    init(errorType: ErrorType) {
        switch errorType {
        case .mapJsonFailed:
            message = "Map to data model failed!!"
        case .emptyData:
            message = "Get empty data!!"
        case .responseFailed:
            message = "Not success responding!!"
        }
    }

    init(moyaError: MoyaError) {
        switch moyaError {
        case .underlying:
            message = "Internet connection offline!!"
        case .parameterEncoding(let error):
            message = error.localizedDescription
        default:
            message = "Error unknown!!"
        }
    }
}
