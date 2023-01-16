// RecommendationMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

/// Модель рекомендованного фильма
final class RecommendationMovie: Object {
    /// Пусть к постеру фильма
    @Persisted var posterPath: String?

    convenience init(json: JSON) {
        self.init()
        posterPath = json["poster_path"].stringValue
    }
}
