// DetailsMoviePresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вход экрана выбора фильмов
protocol DetailsMoviePresenterProtocol: AnyObject {
    var movieDetails: MovieDetails? { get set }
    var id: Int? { get set }
    var recommendationMovies: [RecommendationMovie] { get set }
    var dataService: DataServiceProtocol { get }
    var imageService: ImageServiceProtocol { get }

    func fetchRecommendationMovies()
    func fetchDetailsMovie()
    func popToRootVC()
}
