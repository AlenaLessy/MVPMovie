// NetworkServiceTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тест сетевого сервиса
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?
    private var movies: [Movie]?
    private var detailsMovie: MovieDetails?
    private var recommendationMovies: [RecommendationMovie]?

    // MARK: - Public Methods

    override func setUp() {
        networkService = MockNetworkService()
    }

    override func tearDown() {
        networkService = nil
        movies = nil
        detailsMovie = nil
        recommendationMovies = nil
    }

    func testFetchMovies() {
        movies = [Movie]()
        var catchMovies: [Movie] = []

        networkService = MockNetworkService(movies: movies)
        func fetchMovies(kind: MovieKind, page: Int, completion: (([Movie]) -> ())?) {
            networkService?.fetchMovies(kind: kind, page: page) { result in
                switch result {
                case let .success(movies):
                    completion?(movies)
                case .failure(.unknown):
                    print(NetworkError.unknown.description)
                    completion?(Array())
                case .failure(.decodingFailure):
                    print(NetworkError.decodingFailure.description)
                    completion?(Array())
                case .failure(.urlFailure):
                    print(NetworkError.urlFailure.description)
                    completion?(Array())
                }
            }

            fetchMovies(kind: .popular, page: 0) { result in
                catchMovies = result
            }
            XCTAssertEqual(catchMovies.count, 20)
        }
    }

    func testFetchDetailsMovie() {
        detailsMovie = MovieDetails()
        var catchMovieDetails: MovieDetails?

        func fetchDetailsMovie
        (id: Int, completion: ((MovieDetails) -> ())?) {
            networkService?.fetchDetailsMovie(id: id) { result in
                switch result {
                case let .success(detailsMovie):
                    completion?(detailsMovie)
                case .failure(.unknown):
                    print(NetworkError.unknown.description)
                    completion?(MovieDetails())
                case .failure(.decodingFailure):
                    print(NetworkError.decodingFailure.description)
                    completion?(MovieDetails())
                case .failure(.urlFailure):
                    print(NetworkError.urlFailure.description)
                    completion?(MovieDetails())
                }
            }

            networkService = MockNetworkService(detailsMovie: detailsMovie)
            fetchDetailsMovie(id: 0) { movieDetails in
                catchMovieDetails = movieDetails
            }

            XCTAssertNotNil(catchMovieDetails)
        }
    }

    func testRecommendation() {
        recommendationMovies = [RecommendationMovie]()
        var catchMovies: [RecommendationMovie] = []

        networkService = MockNetworkService(recommendationMovies: recommendationMovies)
        func fetchRecommendationMovies(id: Int, completion: (([RecommendationMovie]) -> ())?) {
            networkService?.fetchRecommendationsMovie(id: id) { result in
                switch result {
                case let .success(recommendationMovies):
                    completion?(recommendationMovies)
                case .failure(.unknown):
                    print(NetworkError.unknown.description)
                    completion?(Array())
                case .failure(.decodingFailure):
                    print(NetworkError.decodingFailure.description)
                    completion?(Array())
                case .failure(.urlFailure):
                    print(NetworkError.urlFailure.description)
                    completion?(Array())
                }
            }
            fetchRecommendationMovies(
                id: id
            ) { result in
                catchMovies = result
            }
            XCTAssertEqual(catchMovies.count, 21)
        }
    }
}
