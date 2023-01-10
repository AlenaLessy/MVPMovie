// AssemblyModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AssemblyBuilderProtocol {
    func createMoviesModule(router: MoviesRouter) -> UIViewController
    func createDetailsMovieModule(id: Int, router: MoviesRouter) -> UIViewController
}

/// Составление вью-контроллеров
class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createMoviesModule(router: MoviesRouter) -> UIViewController {
        let view = MoviesViewController()
        let networkService = NetworkService()
        let presenter = MoviesPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }

    func createDetailsMovieModule(id: Int, router: MoviesRouter) -> UIViewController {
        let view = DetailsMovieViewController()
        let networkService = NetworkService()
        let presenter = DetailsMoviePresenter(view: view, networkService: networkService, movieId: id, router: router)
        view.presenter = presenter
        return view
    }
}