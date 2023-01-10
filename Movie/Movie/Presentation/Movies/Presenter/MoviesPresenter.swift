// MoviesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана выбора фильмов
final class MoviesPresenter: MoviesPresenterProtocol {
    // MARK: - Public Properties

    let networkService: NetworkServiceProtocol!

    weak var view: MoviesViewProtocol?

    var router: MoviesRouterProtocol?
    var currentKind: MovieKind = .topRated
    var movies: [Movie]?
    var page = 1
    var totalPages = 1
    var isLoading = false
    var topRatedButtonAlpha = 0.5
    var popularButtonAlpha = 0.5
    var upcomingButtonAlpha = 0.5

    // MARK: - Initializers

    required init(view: MoviesViewProtocol, networkService: NetworkServiceProtocol, router: MoviesRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        requestMovies(.topRated)
    }

    // MARK: - Public Methods

    func requestMovies(_ kind: MovieKind, pagination: Bool = false) {
        isLoading = true
        view?.startActivityIndicator()
        page = pagination ? page + 1 : page
        networkService.requestMovies(kind: kind, page: page) { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            DispatchQueue.main.async {
                self.view?.stopActivityIndicatorAndRefreshControl()
            }
            switch result {
            case let .success(response):
                self.page = response.page
                self.totalPages = response.totalPages
                self.movies = pagination ? (self.movies ?? []) + response.movies : response.movies
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

    func handleChangedKind(to identifier: String?) {
        guard let identifier,
              let kind = MovieKind(rawValue: identifier)
        else { return }
        view?.scrollToTop()
        guard currentKind != kind else { return }
        movies = []
        view?.reloadTableView()
        page = 1
        currentKind = kind
        requestMovies(currentKind)
        topRatedButtonAlpha = kind == .topRated ? 1 : 0.5
        popularButtonAlpha = kind == .popular ? 1 : 0.5
        upcomingButtonAlpha = kind == .upcoming ? 1 : 0.5
        view?.setupAlpha()
    }

    func newFetchMovies(to indexPathRow: Int) {
        guard let movies else { return }
        let isLastCell = indexPathRow == movies.count - 1
        guard isLastCell, !isLoading, !movies.isEmpty else { return }
        requestMovies(currentKind, pagination: true)
    }

    func refreshControlAction() {
        page = 1
        requestMovies(currentKind)
    }

    func tapDetailsMovie(id: Int) {
        router?.showDetail(id: id)
    }
}
