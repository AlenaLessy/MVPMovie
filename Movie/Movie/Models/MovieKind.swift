// MovieKind.swift
// Copyright © RoadMap. All rights reserved.

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
