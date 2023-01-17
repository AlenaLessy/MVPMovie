// MockAssemblyModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import UIKit

///
final class MockAssemblyModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMoviesModule(router: MoviesRouterProtocol) -> UIViewController {
        UIViewController()
    }

    func makeDetailsMovieModule(id: Int, router: MoviesRouterProtocol) -> UIViewController {
        UIViewController()
    }

    func makeImageService() -> ImageServiceProtocol {
        ImageService(fileManagerService: FileManagerService(), imageApiService: ImageApiService())
    }

    func makeDataService() -> DataServiceProtocol {
        DataService(networkService: NetworkService(), realmService: RealmService())
    }
}
