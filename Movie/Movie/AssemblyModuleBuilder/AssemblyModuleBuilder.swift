// AssemblyModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сборки модулей
protocol AssemblyBuilderProtocol {
    func makeMoviesModule(router: MoviesRouterProtocol) -> UIViewController
    func makeDetailsMovieModule(id: Int, router: MoviesRouterProtocol) -> UIViewController
}

/// Составление модулей
final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMoviesModule(router: MoviesRouterProtocol) -> UIViewController {
        let view = MoviesViewController()
        let dataService = makeDataService()

        let imageService = makeImageService()
        let presenter = MoviesPresenter(
            view: view,
            dataProvider: dataService,
            router: router,
            imageService: imageService
        )
        view.presenter = presenter
        return view
    }

    func makeDetailsMovieModule(id: Int, router: MoviesRouterProtocol) -> UIViewController {
        let view = DetailsMovieViewController()
        let dataService = makeDataService()
        let imageService = makeImageService()
        let presenter = DetailsMoviePresenter(
            view: view,
            dataService: dataService,
            id: id,
            router: router,
            imageService: imageService
        )
        view.presenter = presenter
        return view
    }

    func makeImageService() -> ImageServiceProtocol {
        let fileManagerService = FileManagerService()
        let imageApiService = ImageApiService()
        let imageService = ImageService(fileManagerService: fileManagerService, imageApiService: imageApiService)
        return imageService
    }

    func makeDataService() -> DataServiceProtocol {
        let networkService = NetworkService()
        let realmService = RealmService()
        let dataProvider = DataService(networkService: networkService, realmService: realmService)
        return dataProvider
    }
}
