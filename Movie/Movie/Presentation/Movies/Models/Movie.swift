// Movie.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import SwiftyJSON

/// Модель фильма
final class Movie: Object {
    /// Id  фильма
    @Persisted(primaryKey: true) var id: Int
    /// Путь к постеру фильма
    @Persisted var posterPath: String?
    /// Описание
    @Persisted var overview: String
    /// Дата релиза
    @Persisted var releaseDate: String
    /// Название
    @Persisted var title: String
    /// Рейтинг
    @Persisted var rating: Double
    /// Текущая страница с фильмами
    @Persisted var page: Int
    /// Общее количество страниц с фильмами
    @Persisted var totalPages: Int

    @Persisted var movieKind: String

    convenience init(json: JSON, page: Int, totalPages: Int, movieKind: MovieKind) {
        self.init()
        id = json["id"].intValue
        posterPath = json["poster_path"].stringValue
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue
        title = json["title"].stringValue
        rating = json["vote_average"].doubleValue
        self.page = page
        self.totalPages = totalPages
        self.movieKind = movieKind.rawValue
    }
}
