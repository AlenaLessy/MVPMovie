// Movie.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Модель фильма
struct Movie {
    /// Id  фильма
    let id: Int
    /// Путь к постеру фильма
    let posterPath: String?
    /// Описание
    let overview: String
    /// Дата релиза
    let releaseDate: String
    /// Название
    let title: String
    /// Рейтинг
    let rating: Double

    init(json: JSON) {
        id = json["id"].intValue
        posterPath = json["poster_path"].stringValue
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue
        title = json["title"].stringValue
        rating = json["vote_average"].doubleValue
    }
}
