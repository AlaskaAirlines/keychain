// KeychainAccess
//
// Copyright (c) 2025 Alaska Airlines
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
@testable import KeychainAccess

class KeychainItemTests: KeychainBaseCase {
    func testKeychainItem_TypeKeyReturnsExpectedDescription() {
        XCTAssertEqual(TestCard.typeKey, "TestCard")
        XCTAssertEqual(TestUser.typeKey, "TestUser")
    }

    func testKeychainItem_DataEncodingDecodingReturnsExpectedResult() {
        do {
            // Given, When
            let cardData = try card.data()
            let userData = try user.data()

            let decodedCard = try PropertyListDecoder().decode(TestCard.self, from: cardData)
            let decodedUser = try PropertyListDecoder().decode(TestUser.self, from: userData)

            // Then
            XCTAssertEqual(decodedCard.number, card.number)
            XCTAssertEqual(decodedUser.name, user.name)

        } catch { XCTFail("Failed to encode / decode item data.") }
    }
}
