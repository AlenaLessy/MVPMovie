// DetailsMoviePresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вход экрана выбора фильмов
protocol DetailsMoviePresenterProtocol: AnyObject {
    var movieDetails: MovieDetails? { get set }
    var id: Int? { get set }
    var recommendationMovies: [RecommendationMovie] { get set }
    var networkService: NetworkServiceProtocol { get }

    func fetchRecommendationMovies()
    func fetchMovieDetails()
    func popToRootVC()
}
