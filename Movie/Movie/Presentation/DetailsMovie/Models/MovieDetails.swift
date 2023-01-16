// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

// /// Модель деталей фильма
// struct MovieDetails {
//    /// Путь к постеру фильма
//    let posterPath: String
//    /// Описание
//    let overview: String
//    /// Название
//    let title: String
//    /// Райтинг
//    let rating: Double
//    /// Слоган фильма
//    let tagline: String
//    /// Дата релиза
//    let releaseDate: String
//    /// Время фильма
//    let runtime: Int
//    /// Страна производства
//    let productionCountries: [String]
//    /// Id фильма
//    let id: Int
//
//    init(json: JSON) {
//        posterPath = json["backdrop_path"].stringValue
//        overview = json["overview"].stringValue
//        title = json["title"].stringValue
//        rating = json["vote_average"].doubleValue
//        tagline = json["tagline"].stringValue
//        releaseDate = json["release_date"].stringValue
//        runtime = json["runtime"].intValue
//
//        //  productionCountries.forEach { self.productionCountries.append($0) }
//        productionCountries = json["production_countries"].arrayValue.map { $0["name"].stringValue }
//        id = json["id"].intValue
//    }
// }

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
