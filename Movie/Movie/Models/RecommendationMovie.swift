//
//  RecommendationMovie.swift
//  Movie
//
//  Created by Алена Панченко on 28.10.2022.
//

import Foundation

/// Модель рекомендованного фильма
struct RecommendationMovie: Decodable {
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
