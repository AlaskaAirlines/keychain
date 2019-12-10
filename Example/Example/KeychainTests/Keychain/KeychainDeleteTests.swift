// Keychain
//
// Copyright (c) 2019 Alaska Airlines
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

class KeychainDeleteTests: KeychainBaseCase {
    func testKeychain_DeleteOneItem_Success() {
        // Given
        var keychainItems: [User]?
        var keychainError: Error?

        // When
        do {
            try distinctUsers.forEach { try keychain.save($0) }

            // Ensure all items are successfully saved.
            XCTAssertEqual(try keychain.items(ofType: User.self)?.count, 2)

            // Query all items, get the first one and delete it.
            if
                let items = try keychain.items(ofType: User.self),
                let item = items.first {
                try keychain.delete(item)
            }

            // Query keychain for all items.
            keychainItems = try keychain.items(ofType: User.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainItems)
        XCTAssertEqual(keychainItems?.count, 1)
    }

    func testKeychain_DeleteAll_SpecificType_Success() {
        // Given
        var keychainCards: [Card]?
        var keychainUsers: [User]?
        var keychainError: Error?

        // When
        do {
            try distinctUsers.forEach { try keychain.save($0) }
            try keychain.save(card)

            // Ensure items are saved to the Keychain.
            XCTAssertNotNil(try keychain.items(ofType: Card.self))
            XCTAssertNotNil(try keychain.items(ofType: User.self))

            // Delete all users. Keep Card types.
            try keychain.deleteAll(ofType: User.self)

            // Query keychain for all items.
            keychainCards = try keychain.items(ofType: Card.self)
            keychainUsers = try keychain.items(ofType: User.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNil(keychainUsers)
        XCTAssertNotNil(keychainCards)

        XCTAssertEqual(keychainCards?.count, 1)
        XCTAssertEqual(keychainCards?.first?.name, card.name)
        XCTAssertEqual(keychainCards?.first?.number, card.number)
    }
}
