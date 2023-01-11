// MoviesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана выбора фильмов
final class MoviesPresenter: MoviesPresenterProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let one = 1
        static let fullAlphaValue = 1.0
        static let halfAlphaValue = 0.5
    }

    // MARK: - Public Properties

    let networkService: NetworkServiceProtocol

    weak var view: MoviesViewProtocol?

    var router: MoviesRouterProtocol?
    var currentKind: MovieKind = .topRated
    var movies: [Movie]?
    var page = Constants.one
    var totalPages = Constants.one
    var isLoading = false
    var topRatedButtonAlpha = Constants.halfAlphaValue
    var popularButtonAlpha = Constants.halfAlphaValue
    var upcomingButtonAlpha = Constants.halfAlphaValue

    // MARK: - Initializers

    required init(view: MoviesViewProtocol, networkService: NetworkServiceProtocol, router: MoviesRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchMovies(.topRated)
    }

    // MARK: - Public Methods

    func fetchMovies(_ kind: MovieKind, pagination: Bool = false) {
        isLoading = true
        view?.startActivityIndicator()
        page = pagination ? page + Constants.one : page
        networkService.fetchMovies(kind: kind, page: page) { [weak self] result in
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
        page = Constants.one
        currentKind = kind
        fetchMovies(currentKind)
        topRatedButtonAlpha = kind == .topRated ? Constants.fullAlphaValue : Constants.halfAlphaValue
        popularButtonAlpha = kind == .popular ? Constants.fullAlphaValue : Constants.halfAlphaValue
        upcomingButtonAlpha = kind == .upcoming ? Constants.fullAlphaValue : Constants.halfAlphaValue
        view?.setupAlpha()
    }

    func newFetchMovies(to indexPathRow: Int) {
        guard let movies else { return }
        let isLastCell = indexPathRow == movies.count - Constants.one
        guard isLastCell, !isLoading, !movies.isEmpty else { return }
        fetchMovies(currentKind, pagination: true)
    }

    func refreshControlAction() {
        page = Constants.one
        fetchMovies(currentKind)
    }

    func tapDetailsMovie(id: Int) {
        router?.showDetail(id: id)
    }
}
