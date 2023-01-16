// DetailsMoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана деталей о фильме
final class DetailsMoviePresenter: DetailsMoviePresenterProtocol {
    // MARK: - Public Properties

    let dataService: DataServiceProtocol
    let imageService: ImageServiceProtocol

    weak var view: DetailsMovieViewProtocol?
    var router: MoviesRouterProtocol?
    var movieDetails: MovieDetails?
    var id: Int?
    var recommendationMovies: [RecommendationMovie] = []

    // MARK: - Initializers

    required init(
        view: DetailsMovieViewProtocol,
        dataService: DataServiceProtocol,
        id: Int,
        router: MoviesRouterProtocol, imageService: ImageServiceProtocol
    ) {
        self.view = view
        self.dataService = dataService
        self.id = id
        self.router = router
        self.imageService = imageService
        fetchRecommendationMovies()
        fetchDetailsMovie()
    }

    // MARK: - Public Methods

    func fetchDetailsMovie() {
        guard let id else { return }
        dataService.fetchDetailsMovie(id: id) { [weak self] result in
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
        dataService.fetchRecommendationMovie(id: id) { [weak self] result in
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
