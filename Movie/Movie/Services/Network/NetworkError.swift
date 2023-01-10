// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вид сетевых ошибок
enum NetworkError: Error {
    case unknown
    case decodingFailure
    case urlFailure

    var description: String {
        switch self {
        case .unknown:
            return "Неизвестная ошибка"
        case .decodingFailure:
            return "Ошибка декодирования"
        case .urlFailure:
            return "Ошибка URL"
        }
    }
}
