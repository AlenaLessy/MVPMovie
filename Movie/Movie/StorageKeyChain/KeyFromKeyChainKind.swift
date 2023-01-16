// KeyFromKeyChainKind.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вид сетевых ошибок
enum KeyFromKeyChainKind: String {
    case apiKey

    var description: String {
        switch self {
        case .apiKey:
            return "apiKey"
        }
    }
}
