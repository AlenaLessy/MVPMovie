//
//  MovieResponse.swift
//  Movie
//
//  Created by Алена Панченко on 28.10.2022.
//

import Foundation

/// Модель массива фильмов
struct MovieResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }

    let movies: [Movie]
    let page: Int
    let totalPages: Int
}
