//
//  PopulationDataUITests.swift
//  PopulationDataUITests
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import XCTest


final class PopulationDataUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testPopulationListDisplays() {

        let populationTableView = app.tables["populationTableView"]

        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "cells.count > 0"), object: populationTableView)

        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        XCTAssertEqual(result, .completed, "The population list table view should display data.")
    }

    func testSegmentSwitchingUpdatesContent() {
        let segmentedControl = app.segmentedControls["populationSegmentedControl"]
        XCTAssertTrue(segmentedControl.exists, "Segmented control should exist.")

        let populationTableView = app.tables["populationTableView"]

        XCTAssertEqual(segmentedControl.buttons.element(boundBy: 0).label, "States", "First segment should be 'States'")
        let initialCellCount = populationTableView.cells.count
        XCTAssertGreaterThan(initialCellCount, 0, "There should be cells displayed in the 'States' segment.")

        let nationsButton = segmentedControl.buttons["Nations"]
        nationsButton.tap()

        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "cells.count > 0"), object: populationTableView)
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed, "The table view should display data for the 'Nations' segment.")

        let newCellCount = populationTableView.cells.count
        XCTAssertNotEqual(initialCellCount, newCellCount, "The cell count should be different when switching segments.")
    }
}
