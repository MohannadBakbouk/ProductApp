//
//  ProductsUITests.swift
//  ProductAppUITests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest

private let collectionIdentifier = "ProductsCollection"

final class ProductsUITests: CustomXCTestCase {

    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
        setupNormalServer()
        app.launch()
    }

    override func tearDownWithError() throws {
        server.stop()
        app.terminate()
    }

    func testIsNavigationBarHidden() throws {
       XCTAssert(app.navigationBars.count == 0)
    }
    
    func testIsSearchBarShown() throws {
        XCTAssert(app.searchFields["Search"].waitForExistence(timeout: 5))
    }
    
    func testIsFiltersButtonShown() throws {
        XCTAssert(app.buttons["FiltersButton"].waitForExistence(timeout: 5))
    }
    
    func testIsSubtitleShown() throws {
        XCTAssert(app.staticTexts["Discovery new places"].waitForExistence(timeout: 5))
    }

    func testAreProductsShown() throws {
        XCTAssert(app.collectionViews[collectionIdentifier].waitForExistence(timeout: 3))
        XCTAssert(app.collectionViews[collectionIdentifier].cells.count > 0)
    }
    
    func testTappingOnProductItemPresentDetailsScreen() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to appear")], timeout: 2)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.staticTexts["Menu"].exists)
        XCTAssert(app.staticTexts["Details"].exists)
    }

    func testTappingFiltersButtonPresentFiltersScreen() throws {
       _ = app.buttons["FiltersButton"].waitForExistence(timeout: 2)
        app.buttons["FiltersButton"].tap()
        XCTAssert(app.tables["FiltersTable"].waitForExistence(timeout: 2))
    }
    
    func testCachedProductsWhenThereIsError(){
        switchToFailedServer()
        app.launch()
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for the app gets home screen")], timeout: 2)
        XCTAssert(app.collectionViews[collectionIdentifier].cells.count > 0)
    }
}
