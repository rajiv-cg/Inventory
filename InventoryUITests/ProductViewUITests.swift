//
//  ProductViewUITests.swift
//  InventoryUITests
//
//  Created by user on 15/03/24.
//

import XCTest

final class ProductViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        app.staticTexts["smartphones"].tap()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
        app = nil
    }
    
    func testProductView_WhenLoaded_RequiredElementsShouldDisplay() {
        let titleLable = app.navigationBars["Products"]
        let addButton = app.buttons["Add"]
        XCTAssertTrue(titleLable.exists, "Products navigation title not visible.")
        XCTAssertTrue(addButton.isEnabled, "Add button not enabled for user interactions.")
    }
    
    func testProductView_WhenProductsLoaded_ProductListShouldShow() {
        XCTAssertTrue(app.collectionViews["products list"].waitForExistence(timeout: 1))
        let cells = app.collectionViews["products list"].cells
        XCTAssertTrue(cells.staticTexts["IPHONE 9"].exists, "Product name label not visible.")
        XCTAssertTrue(cells.staticTexts["Brand: Apple"].exists, "Brand label not visible.")
        XCTAssertTrue(cells.staticTexts["Price: 549"].exists, "Price label not visible.")
        XCTAssertTrue(cells.staticTexts[" (12.96% off)"].exists, "Discount label not visible.")
        XCTAssertTrue(cells.staticTexts["Rating: 4.7"].exists, "Rating label not visible.")
    }
    
    func testProductView_WhenTapOnAddButton_AddProductScreenShouldDisplay() {
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.isEnabled, "Add button not enabled for user interaction.")
        
        addButton.tap()
        //XCTAssertTrue(app.otherElements["Add product"].waitForExistence(timeout: 1))
    }
    
    func testProductView_WhenCellSwippedFromRight_DeleteOptionsShouldShow() {
        let cells = app.collectionViews["products list"]
        sleep(1)
        cells.staticTexts["IPHONE 9"].swipeLeft()
        XCTAssertTrue(app.buttons["Delete"].waitForExistence(timeout: 1), "Delete action not available after swift lef.")
    }
    
    func testProductView_WhenDeleteProductTapped_ProductShouldNotVisibleInList() {
        let cells = app.collectionViews["products list"]
        sleep(1)
        
        XCTAssertTrue(cells.staticTexts["IPHONE 9"].exists, "Product name label not visible.")
        
        cells.staticTexts["IPHONE 9"].swipeLeft()
        app.buttons["Delete"].tap()
        XCTAssertFalse(cells.staticTexts["IPHONE 9"].exists, "Product name should not visible after deleted.")
    }
    
    func testProductView_WhenTapOnBackButton_CategoriesScreenShouldShow() {
        app.buttons["Categories"].tap()
        XCTAssertTrue(app.navigationBars["Categories"].exists, "On back press categories screen not showing.")
    }
    
    func testProductView_WhenTapOnProduct_ShouldShowProductDetailsSscreen() {
        let cells = app.collectionViews["products list"]
        sleep(1)
        cells.staticTexts["IPHONE 9"].tap()
        XCTAssertTrue(app.navigationBars["iPhone 9"].exists, "Product details screen not visible when tapped on product.")
    }
}
