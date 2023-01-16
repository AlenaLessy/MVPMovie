// DataService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol DataServiceProtocol {
    func fetchMovies(kind: MovieKind, page: Int, completion: ((Result<[Movie], NetworkError>) -> ())?)
    func fetchDetailsMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?)
    func fetchRecommendationMovie(id: Int, completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?)
}

/// Выбор получения данных
final class DataService: DataServiceProtocol {
    // MARK: Private Properties

    private let networkService: NetworkServiceProtocol
    private let realmService: RealmServiceProtocol

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol, realmService: RealmServiceProtocol) {
        self.networkService = networkService
        self.realmService = realmService
    }

    // MARK: - Public Methods

    func fetchMovies(kind: MovieKind, page: Int, completion: ((Result<[Movie], NetworkError>) -> ())?) {
        if let realmResults = realmService.fetchMovies(movieKind: kind, Movie.self),
           !Array(realmResults).isEmpty,
           Array(realmResults).contains(where: { $0.page == page })
        // swiftlint: disable all
        {
            // swiftlint: enable all
            completion?(.success(Array(realmResults)))
        } else {
            fetchApiMovie(kind: kind, page: page) { movies in
                completion?(.success(movies))
            }
        }
    }

    func fetchDetailsMovie(id: Int, completion: ((Result<MovieDetails, NetworkError>) -> ())?) {
        if let realmResults = realmService.fetchMovieDetails(id: id, MovieDetails.self) {
            completion?(.success(realmResults))
        } else {
            fetchApiDetailsMovie(id: id) { movie in
                completion?(.success(movie))
            }
        }
    }

    func fetchRecommendationMovie(id: Int, completion: ((Result<[RecommendationMovie], NetworkError>) -> ())?) {
        if let realmResults = realmService.fetchRecommendationMovies(id: id, RecommendationMovie.self),
           !Array(realmResults).isEmpty
        // swiftlint: disable all
        {
            // swiftlint: enable all
            let result = Array(realmResults)
            completion?(.success(result))
        } else {
            fetchApiRecommendationMovies(id: id) { movies in
                completion?(.success(movies))
            }
//            networkService.fetchRecommendationsMovie(id: id) { [weak self] result in
//                switch result {
//                case let .success(response):
//                    completion?(.success(response))
//                    let result = Array(response)
//                    self?.realmService.saveObjects(items: result, update: .error)
//                case .failure:
//                    completion?(.failure(.unknown))
//                }
//            }
        }
    }

    // MARK: - Private Methods

    private func fetchApiMovie(kind: MovieKind, page: Int, completion: (([Movie]) -> ())?) {
        networkService.fetchMovies(kind: kind, page: page) { [weak self] result in
            switch result {
            case let .success(response):
                completion?(response)
                self?.realmService.saveObjects(items: response, update: .modified)
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
    }

    private func fetchApiDetailsMovie(id: Int, completion: ((MovieDetails) -> ())?) {
        networkService.fetchDetailsMovie(id: id) { [weak self] result in
            switch result {
            case let .success(response):
                completion?(response)
                self?.realmService.saveObject(items: response)
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
    }

    private func fetchApiRecommendationMovies(id: Int, completion: (([RecommendationMovie]) -> ())?) {
        networkService.fetchRecommendationsMovie(id: id) { [weak self] result in
            switch result {
            case let .success(response):
                completion?(response)
                self?.realmService.saveObjects(items: response, update: .error)
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
    }
}
