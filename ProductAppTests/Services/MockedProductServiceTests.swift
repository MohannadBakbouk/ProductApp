//
//  MockedProductServiceTests.swift
//  ProductAppTests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import ProductApp

final class MockedProductServiceTests: XCTestCase {
    var productService: ProductServiceProtocol!
    var disposeBag : DisposeBag!
    var scheduler : TestScheduler!

    override func setUpWithError() throws {
        productService = MockedProductService()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        productService = nil
        scheduler = nil
        disposeBag = nil
    }
    
    func testFetchingProducts() throws {
        let products = scheduler.createObserver([Product].self)
         productService.getProducts()
        .bind(to: products)
        .disposed(by: disposeBag)
        XCTAssert((products.events.first?.value.element?.count  ?? 0) > 10 , "Failed to load items from json file")
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
