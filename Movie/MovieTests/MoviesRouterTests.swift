// MoviesRouterTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тест роутера фильмов
final class MoviesRouterTests: XCTestCase {
    // MARK: - Private Properties

    private var router: MoviesRouterProtocol!
    private var navigationController = MockNavigationController()
    private var assemblyModuleBuilder = AssemblyModuleBuilder()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        router = MoviesRouter(navigationController: navigationController, assemblyModuleBuilder: assemblyModuleBuilder)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testMoviesRouter() {
        router?.showDetail(id: 0)
        let detailsMovieViewController = navigationController.presentedVC
        XCTAssertTrue(detailsMovieViewController is DetailsMovieViewController)
    }
}
