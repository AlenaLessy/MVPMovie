// RecommendationMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель рекомендованного фильма
struct RecommendationMovie {
    /// Пусть к постеру фильма
    let posterPath: String?

    init(json: JSON) {
        posterPath = json["poster_path"].stringValue
    }
}
