//
//  ProductDetailsViewModelTests.swift
//  ProductAppTests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest
import RxSwift
@testable import ProductApp

final class ProductDetailsViewModelTests: XCTestCase {
    var viewModel : ProductDetailsViewModelProtocol!
    var disposeBag : DisposeBag!
    
    override func setUpWithError() throws {
        viewModel = ProductDetailsViewModel(info: ProductViewData(info: MockedProductService.productItem()!))
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
    }
    
    func testAreProductDetailsPublished(){
        var received: ProductViewData? = nil
        viewModel.productDetails
        .subscribe(onNext: { details in
            received = details
        }).disposed(by: disposeBag)
        XCTAssertNotNil(received, "Product's details is not being published")
    }
}
