//
//  ProductsViewModelTests.swift
//  ProductAppTests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import ProductApp

final class ProductsViewModelTests: XCTestCase {
    var viewModel : ProductsViewModelProtocol!
    var disposeBag : DisposeBag!
    var scheduler : TestScheduler!

    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        viewModel = ProductsViewModel(service: MockedProductService(), cacheManager: CacheManager())
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        scheduler = nil
        viewModel = nil
        disposeBag = nil
    }
    
    func testIsLoadingIndicatorPublished(){
         let isLoading = scheduler.createObserver(Bool.self)
         viewModel.isLoading
        .bind(to: isLoading)
        .disposed(by: disposeBag)
         viewModel.loadProducts() // trigger
         XCTAssertRecordedElements(isLoading.events, [true, false])
    }
    
    func testIsRefeshingIndicatorPublished(){
         let isRefreshing = scheduler.createObserver(Bool.self)
         viewModel.isRefreshing
        .bind(to: isRefreshing)
        .disposed(by: disposeBag)
         viewModel.refreshTrigger.onNext(()) // trigger
         XCTAssertRecordedElements(isRefreshing.events, [false, true, false])
    }
    
    func testAreProductsPublished(){
        let products = scheduler.createObserver([ProductViewData].self)
        viewModel.products
        .bind(to: products)
        .disposed(by: disposeBag)
        viewModel.loadProducts()
        let items = products.events.last?.value.element
        XCTAssert((items?.count ?? 0) > 0, "Products is not publishing items")
    }
    
    func testIsErrorPublished(){
        let error = scheduler.createObserver(ErrorDataView?.self)
        let expectedMessage = NetworkError.internetOffline.message
        viewModel.error
        .bind(to: error)
        .disposed(by: disposeBag)
         viewModel.error.onNext(ErrorDataView(with: .internetOffline)) // trigger
         guard let value = error.events.last?.value.element else {
            XCTFail("Error is not publishing the message")
            return
         }
        XCTAssert(value?.message == expectedMessage, "Error is not publishing the message")
    }
    
    func testFilteringBasedOnCategory(){
        let products = scheduler.createObserver([ProductViewData].self)
        let selectedCategory = Category.electronics
        let params = FilterParams(selectedCategory, nil)
         viewModel.products
        .bind(to: products)
        .disposed(by: disposeBag)
         viewModel.loadProducts()
        
        viewModel.selectedFilters.onNext(params) // trigger
        let items = products.events.last?.value.element
        let itemsCount = items?.filter{$0.category != selectedCategory}.count ?? -1
        XCTAssert(itemsCount == 0, "Filtering based on category doesn't work")
    }
    
    func testClearingSelectedFilters(){
        let products = scheduler.createObserver([ProductViewData].self)
        let params = FilterParams(.electronics, nil)
         viewModel.products
        .bind(to: products)
        .disposed(by: disposeBag)
        viewModel.loadProducts()
        viewModel.selectedFilters.onNext(params)
        
        let categoryItems = products.events.last?.value.element
        viewModel.clearFilters.onNext(()) // trigger
        let allItems = products.events.last?.value.element
        XCTAssert((allItems?.count ?? 0) > (categoryItems?.count ?? 0) , "Clearing selected filter doesn't work")
    }
    
    func testSortingProducts(){
        let products = scheduler.createObserver([ProductViewData].self)
        let params = FilterParams(nil, .highToLow)
         viewModel.products
        .bind(to: products)
        .disposed(by: disposeBag)
        viewModel.loadProducts()
        let rawItems = products.events.last?.value.element
        let prices = rawItems?.map{$0.price} ?? []
        
        viewModel.selectedFilters.onNext(params) // trigger
        let sortedItems = products.events.last?.value.element
        
        XCTAssert((sortedItems?.first?.price ==  prices.max()),  "Sorting filter doesn't work")
        XCTAssert((sortedItems?.last?.price  ==  prices.min()) , "Sorting filter doesn't work")
    }
}
