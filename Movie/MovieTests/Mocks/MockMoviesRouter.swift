// MockMoviesRouter.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import UIKit

final class MockMoviesRouter: MoviesRouterProtocol {
    // MARK: - Public Properties

    var navigationController: UINavigationController? = UINavigationController()
    var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializers

    init(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        self.assemblyModuleBuilder = assemblyModuleBuilder
    }

    // MARK: - Public Methods

    func initialViewController() {}

    func popToRoot() {}

    func showDetail(id: Int) {}
}
