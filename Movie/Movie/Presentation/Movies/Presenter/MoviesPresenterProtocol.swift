// MoviesPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вход экрана выбора фильмов
protocol MoviesPresenterProtocol: AnyObject {
    var movies: [Movie]? { get set }
    var currentKind: MovieKind { get set }
    var page: Int { get set }
    var totalPages: Int { get set }
    var isLoading: Bool { get set }
    var topRatedButtonAlpha: Double { get set }
    var popularButtonAlpha: Double { get set }
    var upcomingButtonAlpha: Double { get set }
    var networkService: NetworkServiceProtocol { get }

    init(view: MoviesViewProtocol, networkService: NetworkServiceProtocol, router: MoviesRouterProtocol)

    func requestMovies(_ kind: MovieKind, pagination: Bool)
    func handleChangedKind(to identifier: String?)
    func newFetchMovies(to indexPathRow: Int)
    func refreshControlAction()
    func tapDetailsMovie(id: Int)
}
