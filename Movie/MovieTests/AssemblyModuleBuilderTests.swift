// AssemblyModuleBuilderTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тест сборщика модулей
final class AssemblyModuleBuilderTests: XCTestCase {
    // MARK: - Private Properties

    private var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Public Methods

    override func setUp() {
        assemblyModuleBuilder = AssemblyModuleBuilder()
    }

    override func tearDown() {
        assemblyModuleBuilder = nil
    }

    func testMakeMoviesModule() {
        let router = MockMoviesRouter(assemblyModuleBuilder: MockAssemblyModuleBuilder())
        let movies = assemblyModuleBuilder?.makeMoviesModule(router: router)
        XCTAssertTrue(movies is MoviesViewController)
    }

    func testMakeDetailsMovieModule() {
        let router = MockMoviesRouter(assemblyModuleBuilder: MockAssemblyModuleBuilder())
        let movieDetails = assemblyModuleBuilder?.makeDetailsMovieModule(id: 0, router: router)
        XCTAssertTrue(movieDetails is DetailsMovieViewController)
    }

    func testMakeImageService() {
        let imageServise = assemblyModuleBuilder?.makeImageService()
        XCTAssertTrue(imageServise is ImageService)
    }

    func testMakeDataService() {
        let dataService = assemblyModuleBuilder?.makeDataService()
        XCTAssertTrue(dataService is DataService)
    }
}
