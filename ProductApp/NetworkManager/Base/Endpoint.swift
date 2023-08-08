//
//  Endpoint.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

protocol Endpoint{
    var path : String{get}
    var params: JSON {get}
    var method: Method {get}
}
