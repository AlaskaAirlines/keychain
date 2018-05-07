// Keychain
//
// Copyright (c) 2018 Michael Babiy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import XCTest
@testable import Keychain

class KeychainSaveTests: KeychainBaseCase {
    func testKeychain_SaveItem_Success() {
        // Given
        var keychainItems: [User]?
        var keychainError: Error?

        // When
        do {
            try keychain.save(user)

            // Query keychain for all items of type User.
            keychainItems = try keychain.items(ofType: User.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainItems)
        XCTAssertEqual(keychainItems?.count, 1)
    }

    func testKeychain_SaveIdenticalItem_SavesOnce_Success() {
        // Given
        var keychainItems: [User]?
        var keychainError: Error?

        // When
        do {
            try identicalUsers.forEach { try keychain.save($0) }

            // Query keychain for all items of type User.
            keychainItems = try keychain.items(ofType: User.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainItems)
        XCTAssertEqual(keychainItems?.count, 1)
    }

    func testKeychain_SaveSameItemRepeatedly_SavesOnce_Success() {
        // Given
        var keychainItems: [User]?
        var keychainError: Error?

        // When
        do {
            try keychain.save(user)
            try keychain.save(user)

            // Query keychain for all items of type User.
            keychainItems = try keychain.items(ofType: User.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainItems)
        XCTAssertEqual(keychainItems?.count, 1)
    }

    func testKeychain_SaveDistinctItemTypes_Success() {
        // Given
        var keychainCards: [Card]?
        var keychainUsers: [User]?
        var keychainError: Error?

        // When
        do {
            try keychain.save(card)
            try keychain.save(user)

            // Query keychain for all items of type User & Card.
            keychainCards = try keychain.items(ofType: Card.self)
            keychainUsers = try keychain.items(ofType: User.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainCards)
        XCTAssertNotNil(keychainUsers)

        XCTAssertEqual(keychainCards?.count, 1)
        XCTAssertEqual(keychainUsers?.count, 1)
    }
}
