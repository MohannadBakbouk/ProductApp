//
//  MockedCacheManagerTests.swift
//  ProductAppTests
//
//  Created by Mohannad on 13/08/2023.
//

import XCTest
@testable import ProductApp

final class MockedCacheManagerTests: XCTestCase {
    var cacheManager: CacheManagerProtocol!
    var products: [ProductObject]!

    override func setUpWithError() throws {
        cacheManager = MockedCasheManager()
        products = MockedProductService.products().map{ProductObject(info: $0)}
    }

    override func tearDownWithError() throws {
        cacheManager = nil
        products.removeAll()
    }

    func testAddProduct() throws {
        cacheManager.add(item: products.first!)
        let items =  cacheManager.fetch(entity: ProductObject.self)
        XCTAssert((items?.count ?? 0) > 0 , "Failed to add new product")
    }
    
    func testFetchProducts() throws {
        cacheManager.addBatch(items: products)
        let items = cacheManager.fetch(entity: ProductObject.self)
        XCTAssert((items?.count ?? 0) == products.count , "Failed to fetch products")
    }
    
    func testCountProducts() throws {
        cacheManager.addBatch(items: products)
        let count = cacheManager.recordsCount(entity: ProductObject.self)
        XCTAssert(count == products.count , "count is not equal")
    }
    
    func testUpdateProduct() throws {
        cacheManager.addBatch(items: products)
        let target = products.last!.detached()
        target.title = "Pro Product"
        cacheManager.update(item: target)
        let updatedItem =  cacheManager.fetch(entity: ProductObject.self)?.first(where: {$0.id == target.id})
        XCTAssert(updatedItem?.title == target.title , "Failed to update product's title")
    }
    
    func testDeleteProduct() throws {
        let target = products.last!
        cacheManager.addBatch(items: products)
        cacheManager.delete(item: target)
        let isDeleted =  !(cacheManager.fetch(entity: ProductObject.self) ?? []).contains(where: {$0.id == target.id})
        XCTAssertTrue(isDeleted ,"Failed to delete product")
    }
    
    func testDeleteAllProducts() throws {
        cacheManager.addBatch(items: products)
        cacheManager.deleteAll(entity: ProductObject.self)
        let items =  cacheManager.fetch(entity: ProductObject.self)
        XCTAssertNil(items, "Failed to delete products")
    }
}
