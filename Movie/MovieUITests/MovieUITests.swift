// MovieUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class MovieUITests: XCTestCase {
    // MARK: Private Constants

    private enum Constants {
        static let moviesTableViewIdentifier = "Movies"
        static let detailsMovieTableViewIdentifier = "DetailsMovie"
        static let cellIdentifier = "cellIdentifier3"
        static let popularButtonIdentifier = "popular"
        static let detailsMovieName = "DetailsMovieViewController"
        static let upcomingButtonIdentifier = "upcoming"
    }

    // MARK: - Private Properties

    private let app = XCUIApplication()

    // MARK: - Public Methods

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testPresenceTableView() {
        XCTAssertNotNil(app.tables.matching(identifier: Constants.moviesTableViewIdentifier))
    }

    func testTableViews() {
        let popularButton = app.buttons[Constants.popularButtonIdentifier]
        XCTAssertNotNil(popularButton)
        popularButton.tap()
        let upcomingButton = app.buttons[Constants.upcomingButtonIdentifier]
        XCTAssertNotNil(upcomingButton)
        upcomingButton.tap()
        let moviesTableView = app.tables[Constants.moviesTableViewIdentifier]
        XCTAssertNotNil(moviesTableView)
        moviesTableView.swipeUp()
        moviesTableView.swipeDown()
        moviesTableView.cells.element(matching: .cell, identifier: Constants.cellIdentifier)
        let detailsMovieTable = app.tables[Constants.detailsMovieTableViewIdentifier]
        XCTAssertNotNil(detailsMovieTable)
        sleep(3)
    }

    override func tearDownWithError() throws {}

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
