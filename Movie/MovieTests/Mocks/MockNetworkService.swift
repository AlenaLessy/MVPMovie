// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie
import SwiftyJSON

/// Мок нетворкСервиса
final class MockNetworkService: NetworkServiceProtocol {
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
        guard let jsonURL = Bundle.main.path(forResource: "MockMovies", ofType: "json")
        else {
            completion?(.failure(.urlFailure))
            return
        }
        do {
            let filePath = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: filePath)
            let json = try JSON(data: data)

            let page = JSON(json)["page"].intValue
            let totalPages = JSON(json)["total_pages"].intValue
            let response = JSON(json)["results"].arrayValue
                .map { Movie(json: $0, page: page, totalPages: totalPages, movieKind: kind) }
            completion?(.success(response))
        } catch {
            print("error")
            completion?(.failure(.decodingFailure))
        }
    }

    func fetchDetailsMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?) {
        guard let jsonURL = Bundle.main.path(forResource: "MockDetailsMovie", ofType: "json")
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
            print("error")
            completion?(.failure(.decodingFailure))
        }
    }

    func fetchRecommendationsMovie(
        id: Int,
        completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?
    ) {
        guard let jsonURL = Bundle.main.path(forResource: "MockRecommendationMovie", ofType: "json")
        else {
            completion?(.failure(.urlFailure))
            return
        }
        do {
            let filePath = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: filePath)
            let value = try JSON(data: data)

            let response = JSON(value)["results"].arrayValue
                .map { RecommendationMovie(json: $0, id: id) }
            completion?(.success(response))
        } catch {
            print("error")
            completion?(.failure(.decodingFailure))
        }
    }
}
