// MovieResponse.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Модель массива фильмов
struct MovieResponse {
    /// Фильмы
    let movies: [Movie]
    /// Текущая страница с фильмами
    let page: Int
    /// Общее количество страниц с фильмами
    let totalPages: Int

    init(json: JSON) {
        movies = json["results"].arrayValue.map { Movie(json: $0) }
        page = json["page"].intValue
        totalPages = json["total_pages"].intValue
    }
}
