// MoviesRouter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Роутер экрана фильмов
final class MoviesRouter: MoviesRouterProtocol {
    // MARK: - Public Properties

    var navigationController: UINavigationController?
    var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializers

    init(
        navigationController: UINavigationController,
        assemblyModuleBuilder: AssemblyBuilderProtocol
    ) {
        self.navigationController = navigationController
        self.assemblyModuleBuilder = assemblyModuleBuilder
    }

    // MARK: - Public Methods

    func initialViewController() {
        guard let navigationController,
              let moviesViewController = assemblyModuleBuilder?.makeMoviesModule(router: self)
        else { return }
        navigationController.viewControllers = [moviesViewController]
    }

    func popToRoot() {
        guard let navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }

    func showDetail(id: Int) {
        guard let navigationController,
              let detailMovieViewController = assemblyModuleBuilder?.makeDetailsMovieModule(id: id, router: self)
        else { return }
        navigationController.pushViewController(detailMovieViewController, animated: true)
    }
}
