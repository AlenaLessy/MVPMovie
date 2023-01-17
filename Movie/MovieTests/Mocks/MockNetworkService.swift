// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie
import SwiftyJSON

/// Мок нетворкСервиса
final class MockNetworkService: NetworkServiceProtocol {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let mockMoviesResourceName = "MockMovies"
        static let jsonType = "json"
        static let page = "page"
        static let results = "results"
        static let totalPages = "total_pages"
        static let mockDetailsMovieResourceName = "MockDetailsMovie"
        static let errorText = "Ошибочка"
        static let mockRecommendationMovieResourceName = "MockRecommendationMovie"
    }
    
    // MARK: - Private Properties

    private var movies: [Movie]?
    private var detailsMovie: MovieDetails?
    private var recommendationMovies: [RecommendationMovie]?

    // MARK: - Initializers

    init() {}

    convenience init(movies: [Movie]?) {
        self.init()
        self.movies = movies
    }

    convenience init(detailsMovie: MovieDetails?) {
        self.init()
        self.detailsMovie = detailsMovie
    }

    convenience init(recommendationMovies: [RecommendationMovie]?) {
        self.init()
        self.recommendationMovies = recommendationMovies
    }

    // MARK: - Public Methods

    func fetchMovies(
        kind: MovieKind,
        page: Int,
        completion: ((Result<[Movie], NetworkError>) -> ())?
    ) {
        guard let jsonURL = Bundle.main.path(forResource: Constants.mockMoviesResourceName, ofType: Constants.jsonType)
        else {
            completion?(.failure(.urlFailure))
            return
        }
        do {
            let filePath = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: filePath)
            let json = try JSON(data: data)

            let page = JSON(json)[Constants.page].intValue
            let totalPages = JSON(json)[Constants.totalPages].intValue
            let response = JSON(json)[Constants.results].arrayValue
                .map { Movie(json: $0, page: page, totalPages: totalPages, movieKind: kind) }
            completion?(.success(response))
        } catch {
            print(Constants.errorText)
            completion?(.failure(.decodingFailure))
        }
    }

    func fetchDetailsMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?) {
        guard let jsonURL = Bundle.main.path(forResource: Constants.mockDetailsMovieResourceName, ofType: Constants.jsonType)
        else {
            completion?(.failure(.urlFailure))
            return
        }
        do {
            let filePath = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: filePath)
            let value = try JSON(data: data)

            let response = MovieDetails(json: JSON(value))
            completion?(.success(response))
        } catch {
            print(Constants.errorText)
            completion?(.failure(.decodingFailure))
        }
    }

    func fetchRecommendationsMovie(
        id: Int,
        completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?
    ) {
        guard let jsonURL = Bundle.main.path(forResource: Constants.mockRecommendationMovieResourceName, ofType: Constants.jsonType)
        else {
            completion?(.failure(.urlFailure))
            return
        }
        do {
            let filePath = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: filePath)
            let value = try JSON(data: data)

            let response = JSON(value)[Constants.results].arrayValue
                .map { RecommendationMovie(json: $0, id: id) }
            completion?(.success(response))
        } catch {
            print(Constants.errorText)
            completion?(.failure(.decodingFailure))
        }
    }
}
