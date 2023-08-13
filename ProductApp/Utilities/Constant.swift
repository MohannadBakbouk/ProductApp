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
    static let phone = "01234567895"
    static let address = "Address Str 70, 50111, Cologne"
}

enum API {
    static var baseUrl = "https://fakestoreapi.com/"
    static let localUrl = "http://localhost:8080/"
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

enum Images {
    static let star = "star"
    static let filledStar = "star.fill"
    static let halfFilledStar = "star.leadinghalf.fill"
    static let bars = "line.3.horizontal.decrease.circle.fill"
    static let checkMark = "checkmark"
    static let phone = "phone.fill"
    static let location = "location.fill"
    static let back = "chevron.left"
    static let exclamationmark = "exclamationmark.circle.fill"
}
