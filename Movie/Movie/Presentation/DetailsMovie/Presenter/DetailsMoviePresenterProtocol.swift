// DetailsMoviePresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вход экрана выбора фильмов
protocol DetailsMoviePresenterProtocol: AnyObject {
    var movieDetails: MovieDetails? { get set }
    var movieId: Int? { get set }
    var recommendationMovies: [RecommendationMovie] { get set }

    init(
        view: DetailsMovieViewProtocol,
        networkService: NetworkServiceProtocol,
        movieId: Int,
        router: MoviesRouterProtocol
    )

    func requestRecommendationMovies()
    func requestMovieDetails()
    func popToRootVC()
}
