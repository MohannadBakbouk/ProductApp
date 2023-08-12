//
//  ProductsEndpoint.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

enum ProductsEndpoint: Endpoint{
    case products
    case productDetails

    var path : String {
        switch self {
          case .products: return "products"
          case .productDetails: return "product/details"
        }
    }
    
    var params : JSON{
        switch self {
          case .products: return [:]
          case .productDetails: return ["id": 123]
        }
    }
    
    var method: Method {
        switch self {
        case .products:
            return .Get
        case .productDetails:
            return .Get
        }
    }
}
