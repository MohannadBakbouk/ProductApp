//
//  NetworkManager.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager: NetworkManagerProtocol{
    func request<T>(endpoint: Endpoint) -> Observable<T> where T: Codable{
        guard var url = API.baseUrl.asURL() else {return Observable.error(NetworkError.invalidUrl)}
        _ =  endpoint.method == .Get ? url.append(queryItems: endpoint.params.asQueryItems) : ()
        var request = URLRequest(url: url.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method.rawValue
        request.addValue(API.content, forHTTPHeaderField: "Content-Type")
        request.httpBody = endpoint.method != .Get ? endpoint.params.asData : nil
        return call(request: request)
    }
    
    func call<T>(request: URLRequest) -> Observable<T> where T: Codable {
        return Observable<T>.create { observer in
            let request =  AF.request(request).responseDecodable{(response : DataResponse<T, AFError>) in
                guard case .success(let result) = response.result  else {
                    let error = NetworkError.convert(response.response?.statusCode) ?? NetworkError.convert(response.error)
                    observer.onError(error)
                    return
                }
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create{
                request.cancel()
            }
        }.retry(3)
    }
}
