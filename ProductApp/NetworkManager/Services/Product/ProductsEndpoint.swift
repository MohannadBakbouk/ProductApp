//
//  ProductsEndpoint.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

enum ProductsEndpoint: Endpoint{
    case products

    var path : String {
        switch self {
          case .products: return "products"
        }
    }
    
    var params : JSON{
        switch self {
          case .products: return [:]
        }
    }
    
    var method: Method {
        switch self {
        case .products:
            return .Get
        }
    }
}
