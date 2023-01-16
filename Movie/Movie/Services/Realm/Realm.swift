// Realm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Протокол рилм сервиса
protocol RealmServiceProtocol {
    func saveObjects(items: [Object], update: Realm.UpdatePolicy)
    func fetchMovies<T: Object>(
        movieKind: MovieKind,
        _ type: T.Type
    ) -> Results<T>?
    func fetchMovieDetails<T: Object>(
        id: Int,
        _ type: T.Type
    ) -> T?
    func saveObject(items: Object)
    func fetchRecommendationMovies<T: Object>(
        id: Int,
        _ type: T.Type
    ) -> Results<T>?
}

/// Сохранение и получение данных из рилма
final class RealmService: RealmServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let predicateMovieKindValue = "movieKind == %@"
        static let predicateRecommendationMoviesValue = "id == %@"
    }

    // MARK: - Private Properties

    private var realm: Realm? = try? Realm()

    // MARK: - Public Methods

    func saveObjects(items: [Object], update: Realm.UpdatePolicy) {
        DispatchQueue.main.async {
            do {
                try self.realm?.write {
                    self.realm?.add(items, update: update)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func saveObject(items: Object) {
        DispatchQueue.main.async {
            do {
                try self.realm?.write {
                    self.realm?.add(items)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func fetchMovies<T: Object>(
        movieKind: MovieKind,
        _ type: T.Type
    ) -> Results<T>? {
        let predicate = NSPredicate(format: Constants.predicateMovieKindValue, movieKind.rawValue)
        let objects = realm?.objects(type).filter(predicate)
        print(realm?.configuration.fileURL)
        return objects
    }

    func fetchMovieDetails<T: Object>(
        id: Int,
        _ type: T.Type
    ) -> T? {
        let objects = realm?.object(ofType: type, forPrimaryKey: id)
        return objects
    }

    func fetchRecommendationMovies<T: Object>(
        id: Int,
        _ type: T.Type
    ) -> Results<T>? {
        let predicate = NSPredicate(format: Constants.predicateRecommendationMoviesValue, String(id))
        let objects = realm?.objects(type).filter(predicate)
        return objects
    }
}
