//
//  iOS_BoilerplateUITests.swift
//  iOS-BoilerplateUITests
//
//  Created by Marcus Vinicius Palassi Sales on 12/05/25.
//

import XCTest

final class iOS_BoilerplateUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func test_verify_list_appears() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let listCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(listCell.waitForExistence(timeout: 5), "First Pokémon should appear in the list")
    }
    
    @MainActor
    func test_tap_load_more_button() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.descendants(matching: .table).firstMatch
        XCTAssertTrue(tableView.waitForExistence(timeout: 5), "Table view should be visible")
        let initialCellCount = app.cells.count
        let loadMoreButton = app.buttons["Load More"]
        loadMoreButton.tap()

        // Give it time to load
        sleep(2)

        let newCellCount = app.cells.count
        XCTAssertTrue(newCellCount > initialCellCount, "List should contain more items after loading more")
    }
    
    @MainActor
    func test_tap_load_pokemon_details() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let listCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(listCell.waitForExistence(timeout: 5), "First Pokémon should appear in the list")
        let pokemonName = listCell.staticTexts["pokemonCellNameLabel"].label
        listCell.tap()
        
        sleep(2)
        
        let detailLabel = app.staticTexts["pokemonDetailsNameLabel"].label
        XCTAssertTrue(detailLabel.hasSuffix(pokemonName))
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
