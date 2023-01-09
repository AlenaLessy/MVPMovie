//
//  NetworkService.swift
//  Movie
//
//  Created by Алена Панченко on 25.10.2022.
//

import Foundation

final class NetworkService {
    // MARK: - Private Constants

    private enum Constants {
        static let apiKey = "0ec73b9e206615099e204ec4a0da2380"
        static let baseUrlString = "https://api.themoviedb.org/3/"
        static let queryItemApiKeyName = "api_key"
        static let queryItemLanguageName = "language"
        static let language = "ru-RU"
        static let queryItemPageName = "page"
        static let htttpMethod = "GET"
        static let applicationJson = "application/json"
        static let forHTTPHeaderField = "Content-Type"
        static let movieText = "movie/"
        static let recommendationsText = "/recommendations"
    }

    // MARK: - Private Properties

    static let shared = NetworkService()
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    // MARK: - Private Init

    private init() {}

    // MARK: - Public Methods

    func requestMovies(kind: MovieKind, page: Int, completion: ((Result<MovieResponse, NetworkError>) -> ())?) {
        guard var url = URL(string: Constants.baseUrlString + kind.path) else {
            completion?(.failure(.urlFailure))
            return
        }

        url.append(queryItems: [
            URLQueryItem(name: Constants.queryItemApiKeyName, value: Constants.apiKey),
            URLQueryItem(name: Constants.queryItemLanguageName, value: Constants.language),
            URLQueryItem(name: Constants.queryItemPageName, value: page.description)
        ])

        var request = URLRequest(url: url)
        request.httpMethod = Constants.htttpMethod
        request.setValue(Constants.applicationJson, forHTTPHeaderField: Constants.forHTTPHeaderField)

        session.dataTask(with: request) { [weak self] data, _, _ in
            guard let self else { return }
            if let data {
                guard let movieResponse = try? self.decoder.decode(MovieResponse.self, from: data) else {
                    completion?(.failure(.decodingFailure))
                    return
                }
                completion?(.success(movieResponse))
            } else {
                completion?(.failure(.unknown))
            }
        }.resume()
    }

    func requestMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?) {
        guard var url = URL(string: Constants.baseUrlString + Constants.movieText + id.description) else {
            completion?(.failure(.urlFailure))
            return
        }

        url.append(queryItems: [
            URLQueryItem(name: Constants.queryItemApiKeyName, value: Constants.apiKey),
            URLQueryItem(name: Constants.queryItemLanguageName, value: Constants.language)
        ])

        var request = URLRequest(url: url)
        request.httpMethod = Constants.htttpMethod
        request.setValue(Constants.applicationJson, forHTTPHeaderField: Constants.forHTTPHeaderField)

        session.dataTask(with: request) { [weak self] data, _, _ in
            guard let self else { return }
            guard let data else {
                completion?(.failure(.unknown))
                return
            }
            guard let detail = try? self.decoder.decode(MovieDetails.self, from: data) else {
                completion?(.failure(.decodingFailure))
                return
            }
            completion?(.success(detail))
        }.resume()
    }

    func requestRecommendationsMovie(
        id: Int,
        completion: ((Result<RecommendationMovieResponse, NetworkError>) -> ())?
    ) {
        guard var url = URL(
            string: Constants.baseUrlString + Constants.movieText + id.description + Constants
                .recommendationsText
        ) else {
            completion?(.failure(.urlFailure))
            return
        }

        url.append(queryItems: [
            URLQueryItem(name: Constants.queryItemApiKeyName, value: Constants.apiKey),
            URLQueryItem(name: Constants.queryItemLanguageName, value: Constants.language)
        ])

        var request = URLRequest(url: url)
        request.httpMethod = Constants.htttpMethod
        request.setValue(Constants.applicationJson, forHTTPHeaderField: Constants.forHTTPHeaderField)

        session.dataTask(with: request) { [weak self] data, _, _ in
            guard let self else { return }
            guard let data else {
                completion?(.failure(.unknown))
                return
            }
            guard let detail = try? self.decoder.decode(RecommendationMovieResponse.self, from: data) else {
                completion?(.failure(.decodingFailure))
                return
            }
            completion?(.success(detail))
        }.resume()
    }
}
