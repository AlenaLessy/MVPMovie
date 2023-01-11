// DetailsMoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана деталей о фильме
final class DetailsMoviePresenter: DetailsMoviePresenterProtocol {
    // MARK: - Public Properties

    let networkService: NetworkServiceProtocol

    weak var view: DetailsMovieViewProtocol?
    var router: MoviesRouterProtocol?
    var movieDetails: MovieDetails?
    var movieId: Int?
    var recommendationMovies: [RecommendationMovie] = []

    // MARK: - Initializers

    required init(
        view: DetailsMovieViewProtocol,
        networkService: NetworkServiceProtocol,
        movieId: Int,
        router: MoviesRouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.movieId = movieId
        self.router = router
        requestRecommendationMovies()
        requestMovieDetails()
    }

    // MARK: - Public Methods

    func requestMovieDetails() {
        guard let movieId else { return }
        networkService.fetchMovie(id: movieId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.view?.failure()
                }
            case let .success(movieDetails):
                self.movieDetails = movieDetails
                DispatchQueue.main.async {
                    self.view?.reloadTableView()
                }
            }
        }
    }

    func requestRecommendationMovies() {
        guard let movieId else { return }
        networkService.fetchRecommendationsMovie(id: movieId) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.recommendationMovies = response
                DispatchQueue.main.async {
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
