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

class KeychainSearchTests: KeychainBaseCase {
    func testKeychain_FindUsingIDKey_Success() {
        // Given
        var keychainItem: TestUser?
        var keychainItems: [TestUser]?
        var keychainError: Error?

        // When
        do {
            try distinctUsers.forEach { try keychain.save($0) }

            // Query keychain for all items of type User.
            keychainItem = try keychain.item(ofType: TestUser.self, idKey: "one")
            keychainItems = try keychain.items(ofType: TestUser.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainItem)
        XCTAssertEqual(keychainItems?.count, 2)

        XCTAssertEqual(keychainItem?.name, "one")
    }

    func testKeychain_FindUsingIDKey_ReturnsNil_Success() {
        // Given
        var keychainItem: TestUser?
        var keychainItems: [TestUser]?
        var keychainError: Error?

        // When
        do {
            try distinctUsers.forEach { try keychain.save($0) }

            // Query keychain for all items of type User.
            keychainItem = try keychain.item(ofType: TestUser.self, idKey: "idKey")
            keychainItems = try keychain.items(ofType: TestUser.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNil(keychainItem)
        XCTAssertEqual(keychainItems?.count, 2)
    }

    func testKeychain_FindAll_Success() {
        // Given
        var keychainItems: [TestUser]?
        var keychainError: Error?

        // When
        do {
            try distinctUsers.forEach { try keychain.save($0) }

            // Query keychain for all items of type User.
            keychainItems = try keychain.items(ofType: TestUser.self)
        } catch { keychainError = error }

        // Then
        XCTAssertNil(keychainError)
        XCTAssertNotNil(keychainItems)
        XCTAssertEqual(keychainItems?.count, 2)

        XCTAssertEqual(keychainItems?.first?.name, distinctUsers.first?.name)
        XCTAssertEqual(keychainItems?.last?.name, distinctUsers.last?.name)
    }
}
