// StorageKeyChain.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

final class StorageKeyChain {
    // MARK: - Private Constants

    private enum Constants {
        static let apiKeyName = "API_KEY"
        static let apiKeyKey = "apiKey"
        static let errorText = "Не удалось записать данные в KeyChain"
    }

    // MARK: - Private Properties

    private let apiKeyValue = Bundle.main.infoDictionary?[Constants.apiKeyName] as? String
    private let keyChain = KeychainSwift()
    static let shared = StorageKeyChain()

    // MARK: - Initializers

    private init() {}

    // MARK: - Public Methods

    func safeValueToKeyChain(key: KeyFromKeyChainKind, value: String) {
        guard keyChain.set(value, forKey: key.description)
        else {
            print(Constants.errorText)
            return
        }
    }

    func readValueFromKeyChain(from key: KeyFromKeyChainKind) -> String {
        guard let value = keyChain.get(key.description) else {
            return String()
        }
        return value
    }
}
