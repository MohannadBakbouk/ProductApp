//
//  CustomXCTestCase.swift
//  ProductAppUITests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest
import Swifter

enum Endpoint {
   static let products = "/products"
}

enum EndpointResponse {
    static let products = "ProductsResponse.json"
}

class CustomXCTestCase: XCTestCase {
    var app = XCUIApplication()
    let server = HttpServer()
  
    func setupNormalServer(){
        do {
            let path = try TestUtil.path(for: EndpointResponse.products, in: type(of: self))
            server[Endpoint.products] = shareFile(path)
            try server.start()
        }catch {
            XCTAssert(false, "Swifter Server failed to start.")
        }
    }
    
    func switchToFailedServer(){
        server.stop()
        do {
            server[Endpoint.products] = { _ in
               return HttpResponse.internalServerError
            }
            try server.start()
        }
        catch{
            XCTAssert(false, "Swifter Server failed to start.")
        }
    }
}
