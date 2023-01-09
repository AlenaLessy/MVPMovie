//
//  NetworkError.swift
//  Movie
//
//  Created by Алена Панченко on 28.10.2022.
//

import Foundation

/// Вид сетевых ошибок
enum NetworkError: Error {
    case unknown
    case decodingFailure
    case urlFailure
}
