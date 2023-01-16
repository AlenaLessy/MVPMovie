// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import KeychainSwift
import SwiftyJSON

/// Протокол сетевых запросов
protocol NetworkServiceProtocol {
    func fetchMovies(kind: MovieKind, page: Int, completion: ((Result<[Movie], NetworkError>) -> ())?)
    func fetchDetailsMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?)
    func fetchRecommendationsMovie(
        id: Int,
        completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?
    )
}

/// Cетевые запросы
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let baseUrlString = "https://api.themoviedb.org/3/"
        static let queryItemApiKeyName = "api_key"
        static let queryItemLanguageName = "language"
        static let language = "ru-RU"
        static let queryItemPageName = "page"
        static let htttpMethod = "GET"
        static let movieText = "movie/"
        static let recommendationsText = "/recommendations"
        static let resultsText = "results"
        static let baseImageIRLString = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Private Properties

    private let storageKeyChain = StorageKeyChain()

    // MARK: - Public Methods

    func fetchMovies(kind: MovieKind, page: Int, completion: ((Result<[Movie], NetworkError>) -> ())?) {
        guard let url = URL(string: Constants.baseUrlString + kind.path) else {
            completion?(.failure(.urlFailure))
            return
        }

        let parameters = [
            Constants.queryItemApiKeyName: storageKeyChain.readValueFromKeyChain(from: .apiKey),
            Constants.queryItemLanguageName: Constants.language,
            Constants.queryItemPageName: page.description
        ]

        AF.request(
            url,
            method: HTTPMethod(rawValue: Constants.htttpMethod),
            parameters: parameters
        ).responseJSON { responseJSON in
            switch responseJSON.result {
            case let .success(json):
                let page = JSON(json)["page"].intValue
                let totalPages = JSON(json)["total_pages"].intValue
                let response = JSON(json)[Constants.resultsText].arrayValue
                    .map { Movie(json: $0, page: page, totalPages: totalPages, movieKind: kind) }
                completion?(.success(response))
            case .failure:
                completion?(.failure(.decodingFailure))
            }
        }
    }

    func fetchDetailsMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?) {
        guard let url = URL(string: Constants.baseUrlString + Constants.movieText + id.description) else {
            completion?(.failure(.urlFailure))
            return
        }

        let parameters = [
            Constants.queryItemApiKeyName: storageKeyChain.readValueFromKeyChain(from: .apiKey),
            Constants.queryItemLanguageName: Constants.language
        ]

        AF.request(url, method: HTTPMethod(rawValue: Constants.htttpMethod), parameters: parameters)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case let .success(value):
                    let response = MovieDetails(json: JSON(value))
                    completion?(.success(response))
                case .failure:
                    completion?(.failure(.decodingFailure))
                }
            }
    }

    func fetchRecommendationsMovie(
        id: Int,
        completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?
    ) {
        guard let url = URL(
            string: Constants.baseUrlString + Constants.movieText + id.description + Constants
                .recommendationsText
        ) else {
            completion?(.failure(.urlFailure))
            return
        }

        let parameters = [
            Constants.queryItemApiKeyName: storageKeyChain.readValueFromKeyChain(from: .apiKey),
            Constants.queryItemLanguageName: Constants.language
        ]

        AF.request(url, method: HTTPMethod(rawValue: Constants.htttpMethod), parameters: parameters)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case let .success(value):
                    let response = JSON(value)[Constants.resultsText].arrayValue
                        .map { RecommendationMovie(json: $0, id: id) }
                    completion?(.success(response))
                case .failure:
                    completion?(.failure(.decodingFailure))
                }
            }
    }
}
