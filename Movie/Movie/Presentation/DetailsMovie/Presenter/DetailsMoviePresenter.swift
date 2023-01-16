// DetailsMoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана деталей о фильме
final class DetailsMoviePresenter: DetailsMoviePresenterProtocol {
    // MARK: - Public Properties

    let dataProvider: DataProviderProtocol
    let imageService: ImageServiceProtocol

    weak var view: DetailsMovieViewProtocol?
    var router: MoviesRouterProtocol?
    var movieDetails: MovieDetails?
    var id: Int?
    var recommendationMovies: [RecommendationMovie] = []

    // MARK: - Initializers

    required init(
        view: DetailsMovieViewProtocol,
        dataProvider: DataProviderProtocol,
        id: Int,
        router: MoviesRouterProtocol, imageService: ImageServiceProtocol
    ) {
        self.view = view
        self.dataProvider = dataProvider
        self.id = id
        self.router = router
        self.imageService = imageService
        fetchRecommendationMovies()
        fetchDetailsMovie()
    }

    // MARK: - Public Methods

    func fetchDetailsMovie() {
        guard let id else { return }
        dataProvider.fetchDetailsMovie(id: id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self.view?.failure()
                case let .success(movieDetails):
                    self.movieDetails = movieDetails
                    self.view?.reloadTableView()
                }
            }
        }
    }

    func fetchRecommendationMovies() {
        guard let id else { return }
        dataProvider.fetchRecommendationMovie(id: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.recommendationMovies = response
                DispatchQueue.main.async {
                    self.view?.reloadCollectionView()
                    self.view?.reloadTableView()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.view?.failure()
                }
            }
        }
    }

    func popToRootVC() {
        router?.popToRoot()
    }
}
