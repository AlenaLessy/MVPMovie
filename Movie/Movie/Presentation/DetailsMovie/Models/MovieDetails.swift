// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

final class MovieDetails: Object {
    /// Путь к постеру фильма
    @Persisted var posterPath: String
    /// Описание
    @Persisted var overview: String
    /// Название
    @Persisted var title: String
    /// Райтинг
    @Persisted var rating: Double
    /// Слоган фильма
    @Persisted var tagline: String
    /// Дата релиза
    @Persisted var releaseDate: String
    /// Время фильма
    @Persisted var runtime: Int
    /// Страна производства
    @Persisted var productionCountries: List<String>
    /// Id фильма
    @Persisted(primaryKey: true) var id: Int

    convenience init(json: JSON) {
        self.init()

        posterPath = json["backdrop_path"].stringValue
        overview = json["overview"].stringValue
        title = json["title"].stringValue
        rating = json["vote_average"].doubleValue
        tagline = json["tagline"].stringValue
        releaseDate = json["release_date"].stringValue
        runtime = json["runtime"].intValue
        productionCountries.forEach { self.productionCountries.append($0) }
        id = json["id"].intValue
    }
}
