// AssemblyModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сборки модулей
protocol AssemblyBuilderProtocol {
    func makeMoviesModule(router: MoviesRouter) -> UIViewController
    func makeDetailsMovieModule(id: Int, router: MoviesRouter) -> UIViewController
}

/// Составление модулей
final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMoviesModule(router: MoviesRouter) -> UIViewController {
        let view = MoviesViewController()
        let networkService = NetworkService()
        let presenter = MoviesPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }

    func makeDetailsMovieModule(id: Int, router: MoviesRouter) -> UIViewController {
        let view = DetailsMovieViewController()
        let networkService = NetworkService()
        let presenter = DetailsMoviePresenter(view: view, networkService: networkService, movieId: id, router: router)
        view.presenter = presenter
        return view
    }
}
