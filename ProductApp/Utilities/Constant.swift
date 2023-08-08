//
//  Constant.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

enum App {
    static var name = "Product App"
    static let author = "Mohannad Bakbouk"
}

enum API {
    static let baseUrl = "https://fakestoreapi.com/"
    static let content = "application/json; charset=utf-8"
}

enum ErrorMessages{
    static let  internet = "Please make sure you are connected to the internet"
    static let  server = "an internal error occured in server side please try again later"
    static let  general = "Something went wrong"
    static let  parsing = "an internal error occured while parsing the request please try again later"
    static let  anInternal = "an internal error occured"
    static let  notFound = "the url you have requested is not existed"
    static let  hostNameNotFound =  "the host you have requested is not existed"
}

