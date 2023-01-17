// StorageKeyChainTest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

@testable import Movie
import XCTest

/// Тест кей чейн сервиса
final class StorageKeyChainTest: XCTestCase {
    // MARK: - Private Properties

    private var storageKeyChainService: StorageKeyChainProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        storageKeyChainService = StorageKeyChain()
    }

    override func tearDownWithError() throws {
        storageKeyChainService?.safeValueToKeyChain(key: .apiKey, value: "")
        storageKeyChainService = nil
    }

    func testReadValueFromKeyChain() {
        storageKeyChainService?.safeValueToKeyChain(key: .apiKey, value: "baz")
        let value = storageKeyChainService?.readValueFromKeyChain(from: .apiKey)
        XCTAssertEqual("baz", value)
    }
}
