//
//  ActualProductServiceTests.swift
//  ProductAppTests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest
import RxSwift
import RxCocoa
@testable import ProductApp

final class ActualProductServiceTests: XCTestCase {
    var productService: ProductServiceProtocol!
    var disposeBag : DisposeBag!
    
    override func setUpWithError() throws {
        productService = ProductService()
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        productService = nil
        disposeBag = nil
    }
    
    func testFetchingProducts() throws {
        let expectations = expectation(description: "Loading the products from api")
        var products: [Product] = []
         productService.getProducts()
        .subscribe(onNext: {items in
            products.append(contentsOf: items)
        }, onCompleted: {
            expectations.fulfill()
        })
        .disposed(by: disposeBag)
        
        wait(for: [expectations], timeout: 3)
        XCTAssert(products.count > 10 , "Failed to fetch items from api")
    }
    
    func testRequestWithError() throws {
        let expectations = expectation(description: "get not found error")
        var error: Error?
         productService.getProdutDetails()
        .subscribe(onError: {err in
            error = err
            expectations.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectations], timeout: 5)
        XCTAssert((error as? NetworkError) == NetworkError.notFound , "return not found error")
    }
}
