//
//  FiltersUITests.swift
//  ProductAppUITests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest

final class FiltersUITests: CustomXCTestCase {
    
    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
        setupNormalServer()
        app.launch()
    }

    override func tearDownWithError() throws {
        server.stop()
        app.terminate()
    }

    func testAreControlButtonsShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for the app gets home screen")], timeout: 2)
        app.buttons["FiltersButton"].tap()
        XCTAssert(app.buttons["Reset"].exists)
        XCTAssert(app.buttons["Filters"].exists)
        XCTAssert(app.buttons["Done"].exists)
    }
    
    func testAreCategoriesShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for the app gets home screen")], timeout: 2)
        app.buttons["FiltersButton"].tap()
        let filterCells = app.tables["FiltersTable"].cells
        XCTAssert(filterCells.element(matching: .cell, identifier: "CategorySection").exists)
    }
    
    func testAreSortMethodsShown() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for the app gets home screen")], timeout: 2)
        app.buttons["FiltersButton"].tap()
        let cells = app.tables["FiltersTable"].cells
        XCTAssert(cells.element(matching: .cell, identifier: "SortMethodSection").exists)
    }
    
    func testTappingDoneButtonDismissFilters() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for the app gets home screen")], timeout: 2)
        app.buttons["FiltersButton"].tap()
        XCTAssert(app.tables["FiltersTable"].exists)
        app.buttons["Done"].tap()
        XCTAssert(!app.tables["FiltersTable"].exists)
    }
    
    func testSwipeDownDismissFilters() throws {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for the app gets home screen")], timeout: 2)
        app.buttons["FiltersButton"].tap()
        XCTAssert(app.tables["FiltersTable"].exists)
        app.otherElements["ContaitnerView"].swipeDown()
        XCTAssert(!app.tables["FiltersTable"].exists)
    }
}
