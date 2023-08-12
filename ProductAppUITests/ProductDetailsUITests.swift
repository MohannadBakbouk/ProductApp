//
//  ProductDetailsUITests.swift
//  ProductAppUITests
//
//  Created by Mohannad on 13/08/2023.
//

import XCTest

private let collectionIdentifier = "ProductsCollection"

final class ProductDetailsUITests: CustomXCTestCase {
    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
        setupNormalServer()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        server.stop()
        app.terminate()
    }
    
    func testIsBackShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.buttons["BackButton"].exists)
    }
    
    func testIsProductPhotoShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.images["ProductPhoto"].exists)
    }
    
    func testIsProductTitleShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.staticTexts["ProductTitle"].exists)
    }
    
    func testIsProductDescriptionShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.staticTexts["ProductDescription"].exists)
    }
    
    func testIsProductDetailsShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        print(app.otherElements["ProductDetailsView"].frame)
        XCTAssert(app.otherElements["ProductDetailsView"].exists)
    }
    
    func testAreProductsPhotosShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.collectionViews["CollectionProductPhotos"].exists)
        XCTAssert(app.collectionViews["CollectionProductPhotos"].cells.count > 0)
    }

    func testIsAddressInfoShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.otherElements["AddressView"].exists)
    }
    
    func testIsProductDetailsGettingBiggerAtSwipe() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        let detailsView = app.otherElements["ProductDetailsView"]
        let origin = detailsView.frame
        detailsView.swipeUp()
        XCTAssert(detailsView.frame.height > origin.height)
    }
    
    func testIsNavigateBackWorking() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.otherElements["ProductDetailsView"].exists)
        app.buttons["BackButton"].tap()
        XCTAssert(!app.otherElements["ProductDetailsView"].exists)
    }
}
