//
//  NetworkManager.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

typealias APIResult<T> = Result<T, APIError>
typealias APICompletion<T> = (APIResult<T>) -> Void

struct NetworkManager {

    static func request<T: Mappable>(_ service: APIService, completion: @escaping APICompletion<T>) {
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])

        provider.request(service) { result in
            switch result {
            case .success(let response):
                // check if status code is 200 (200 = success)
                guard response.statusCode == 200 else {
                    let error = APIError(errorType: .responseFailed)
                    completion(.failure(error))
                    return
                }

                // map json to object
                guard let json = try? response.mapJSON() as? [String: Any], let object = T(JSON: json) else {
                    let error = APIError(errorType: .mapJsonFailed)
                    completion(.failure(error))
                    return
                }
                completion(.success(object))

            case .failure(let error):
                let apiError = APIError(moyaError: error)
                completion(.failure(apiError))
            }
        }
    }

    static func request<T: Mappable>(_ service: APIService) -> Observable<APIResult<T>> {
        .create { observer in
            NetworkManager.request(service) { result in
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
