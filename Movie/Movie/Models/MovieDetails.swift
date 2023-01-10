// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель деталей фильма
struct MovieDetails {
    /// Путь к постеру фильма
    let posterPath: String
    /// Описание
    let overview: String
    /// Название
    let title: String
    /// Райтинг
    let rating: Double
    /// Слоган фильма
    let tagline: String
    /// Дата релиза
    let releaseDate: String
    /// Время фильма
    let runtime: Int
    /// Страна производства
    let productionCountries: [String]
    /// Id фильма
    let id: Int

    init(json: JSON) {
        posterPath = json["backdrop_path"].stringValue
        overview = json["overview"].stringValue
        title = json["title"].stringValue
        rating = json["vote_average"].doubleValue
        tagline = json["tagline"].stringValue
        releaseDate = json["release_date"].stringValue
        runtime = json["runtime"].intValue
        productionCountries = json["production_countries"].arrayValue.map { $0["name"].stringValue }
        id = json["id"].intValue
    }
}
