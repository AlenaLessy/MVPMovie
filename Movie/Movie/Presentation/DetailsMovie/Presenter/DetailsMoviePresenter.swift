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
    var id: Int?
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
        id = movieId
        self.router = router
        fetchRecommendationMovies()
        fetchMovieDetails()
    }

    // MARK: - Public Methods

    func fetchMovieDetails() {
        guard let id else { return }
        networkService.fetchMovieDetails(id: id) { [weak self] result in
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

    func fetchRecommendationMovies() {
        guard let id else { return }
        networkService.fetchRecommendationsMovie(id: id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.recommendationMovies = response

                    self.view?.reloadTableView()
                case .failure:
                    self.view?.failure()
                }
            }
        }
    }

    func popToRootVC() {
        router?.popToRoot()
    }
}
