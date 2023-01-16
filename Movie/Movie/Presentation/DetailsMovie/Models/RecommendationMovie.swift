// RecommendationMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

/// Модель рекомендованного фильма
final class RecommendationMovie: Object {
    /// Пусть к постеру фильма
    @Persisted var posterPath: String?
    /// Id фильма для похожих фильмов
    @Persisted var id: String
    convenience init(json: JSON, id: Int) {
        self.init()
        posterPath = json["poster_path"].stringValue
        self.id = String(id)
    }
}
