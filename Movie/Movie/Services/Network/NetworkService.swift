// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

protocol NetworkServiceProtocol {
    func requestMovies(kind: MovieKind, page: Int, completion: ((Result<MovieResponse, NetworkError>) -> ())?)
    func requestMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?)
    func requestRecommendationsMovie(
        id: Int,
        completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?
    )
    func fetchImage(imageUrlPath: String, completion: ((Result<Data, NetworkError>) -> ())?)
}

/// Cетевые запросы
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let apiKey = "0ec73b9e206615099e204ec4a0da2380"
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

    // MARK: - Public Methods

    func requestMovies(kind: MovieKind, page: Int, completion: ((Result<MovieResponse, NetworkError>) -> ())?) {
        guard let url = URL(string: Constants.baseUrlString + kind.path) else {
            completion?(.failure(.urlFailure))
            return
        }

        let parameters = [
            Constants.queryItemApiKeyName: Constants.apiKey,
            Constants.queryItemLanguageName: Constants.language,
            Constants.queryItemPageName: page.description
        ]

        AF.request(
            url,
            method: HTTPMethod(rawValue: Constants.htttpMethod),
            parameters: parameters
        ).responseJSON { responseJSON in
            switch responseJSON.result {
            case let .success(value):
                let response = MovieResponse(json: JSON(value))
                completion?(.success(response))
            case .failure:
                completion?(.failure(.decodingFailure))
            }
        }
    }

    func requestMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?) {
        guard let url = URL(string: Constants.baseUrlString + Constants.movieText + id.description) else {
            completion?(.failure(.urlFailure))
            return
        }

        let parameters = [
            Constants.queryItemApiKeyName: Constants.apiKey,
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

    func requestRecommendationsMovie(
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
            Constants.queryItemApiKeyName: Constants.apiKey,
            Constants.queryItemLanguageName: Constants.language
        ]

        AF.request(url, method: HTTPMethod(rawValue: Constants.htttpMethod), parameters: parameters)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case let .success(value):
                    let response = JSON(value)[Constants.resultsText].arrayValue.map { RecommendationMovie(json: $0) }
                    completion?(.success(response))
                case .failure:
                    completion?(.failure(.decodingFailure))
                }
            }
    }

    func fetchImage(imageUrlPath: String, completion: ((Result<Data, NetworkError>) -> ())?) {
        let imageUrl = "\(Constants.baseImageIRLString)\(imageUrlPath)"
        AF.request(imageUrl).responseData { response in
            switch response.result {
            case let .success(data):
                completion?(.success(data))
            case let .failure(error):
                completion?(.failure(.decodingFailure))
            }
        }
    }
}
