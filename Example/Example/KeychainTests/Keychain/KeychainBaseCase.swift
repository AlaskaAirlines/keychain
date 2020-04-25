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

class KeychainBaseCase: XCTestCase {

    // MARK: Properties

    let keychain = Keychain(.appSpecific(access: .always, serviceName: "ExampleAppTests"))
    let card = TestCard(name: "Steve", number: "1234 5678 9012 3456")
    let user = TestUser(name: "username")

    var distinctUsers: [TestUser] {
        return [
            TestUser(name: "one"),
            TestUser(name: "two")
        ]
    }

    var identicalUsers: [TestUser] {
        return [
            TestUser(name: "one"),
            TestUser(name: "one")
        ]
    }

    // MARK: Override

    override func setUp() {
        super.setUp()

        // Before running each test, check for an empty keychain.
        XCTAssertNil(try keychain.items(ofType: TestCard.self))
        XCTAssertNil(try keychain.items(ofType: TestUser.self))
    }

    override func tearDown() {
        // Before running each test, clear the keychain.
        do {
            try keychain.deleteAll(ofType: TestCard.self)
            try keychain.deleteAll(ofType: TestUser.self)
        } catch { fatalError("Error deleting all items.") }

        super.tearDown()
    }
}
