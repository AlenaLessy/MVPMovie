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
        let dataProvider = makeDataProvider()

        let imageService = makeImageService()
        let presenter = MoviesPresenter(
            view: view,
            dataProvider: dataProvider,
            router: router,
            imageService: imageService
        )
        view.presenter = presenter
        return view
    }

    func makeDetailsMovieModule(id: Int, router: MoviesRouter) -> UIViewController {
        let view = DetailsMovieViewController()
        let dataProvider = makeDataProvider()
        let imageService = makeImageService()
        let presenter = DetailsMoviePresenter(
            view: view,
            dataProvider: dataProvider,
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

    func makeDataProvider() -> DataProviderProtocol {
        let networkService = NetworkService()
        let realmService = RealmService()
        let dataProvider = DataProvider(networkService: networkService, realmService: realmService)
        return dataProvider
    }
}
