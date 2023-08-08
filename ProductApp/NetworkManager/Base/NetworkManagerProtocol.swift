//
//  NetworkManagerProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Alamofire
import RxSwift

public typealias JSON = [String : Any]

protocol NetworkManagerProtocol{
    func request<T: Codable>(endpoint: Endpoint) -> Observable<T>
    func call<T: Codable>(request: URLRequest) -> Observable<T>
}
