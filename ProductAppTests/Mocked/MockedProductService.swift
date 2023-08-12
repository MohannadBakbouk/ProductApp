//
//  MockedProductService.swift
//  ProductAppTests
//
//  Created by Mohannad on 12/08/2023.
//

import Foundation
import RxSwift
@testable import ProductApp

final class MockedProductService: ProductServiceProtocol{
    func getProducts() -> Observable<[Product]> {
        guard let url = Bundle.main.url(forResource: "ProductsResponse", withExtension: "json"),
              let data =  try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode([Product].self, from: data) else {
          return Observable.error(NetworkError.notFound)
        }
        return Observable.just(response)
    }
    
    func getProdutDetails() -> Observable<Product> {
        return Observable.error(NetworkError.notFound)
    }
}
