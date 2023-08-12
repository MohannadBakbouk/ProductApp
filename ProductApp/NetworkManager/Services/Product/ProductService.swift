//
//  ProductService.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift

protocol ProductServiceProtocol {
    func getProducts() -> Observable<[Product]>
    func getProdutDetails() -> Observable<Product> // a fake endpoint to test handling error
}

final class ProductService: ProductServiceProtocol{
    var networkManager : NetworkManagerProtocol
    
    init (networkManager : NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func getProducts() -> Observable<[Product]> {
        return networkManager.request(endpoint: ProductsEndpoint.products)
    }
    
    func getProdutDetails() -> Observable<Product> {
        return networkManager.request(endpoint: ProductsEndpoint.productDetails)
    }
}
