//
//  MovieDetails.swift
//  Movie
//
//  Created by Алена Панченко on 28.10.2022.
//

import Foundation

/// Модель деталей фильма
struct MovieDetails: Decodable {
    //
    enum CodingKeys: String, CodingKey {
        case posterPath = "backdrop_path"
        case overview
        case title
        case rating = "vote_average"
        case tagline
        case releaseDate = "release_date"
        case runtime
        case productionCountries = "production_countries"
        case id
    }

    let posterPath: String
    let overview: String
    let title: String
    let rating: Double
    let tagline: String
    let releaseDate: String
    let runtime: Int
    let productionCountries: [ProductionCountries]
    let id: Int
}
