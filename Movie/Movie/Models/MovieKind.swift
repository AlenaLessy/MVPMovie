//
//  MovieKind.swift
//  Movie
//
//  Created by Алена Панченко on 27.10.2022.
//

import Foundation

/// Вид фильмов
enum MovieKind: String {
    case popular
    case topRated
    case upcoming
}

/// MovieKind + Extension
extension MovieKind {
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        }
    }
}
