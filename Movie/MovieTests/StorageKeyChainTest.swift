// StorageKeyChainTest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

@testable import Movie
import XCTest

/// Тест кей чейн сервиса
final class StorageKeyChainTest: XCTestCase {
    
    // Private Constants
    private enum Constants {
        static let valueText = "foo"
        static let emptyString = ""
    }
    
    // MARK: - Private Properties

    private var storageKeyChainService: StorageKeyChainProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        storageKeyChainService = StorageKeyChain()
    }

    override func tearDownWithError() throws {
        storageKeyChainService?.safeValueToKeyChain(key: .apiKey, value: Constants.emptyString)
        storageKeyChainService = nil
    }

    func testReadValueFromKeyChain() {
        storageKeyChainService?.safeValueToKeyChain(key: .apiKey, value: Constants.valueText)
        let value = storageKeyChainService?.readValueFromKeyChain(from: .apiKey)
        XCTAssertEqual(Constants.valueText, value)
    }
}
