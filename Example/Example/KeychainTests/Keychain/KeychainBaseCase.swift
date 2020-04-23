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

// NOTE: all data in this is dummy data used for testing only. 

import XCTest
@testable import Keychain

class KeychainBaseCase: XCTestCase {

    // MARK: Properties

    let keychain = Keychain(.appSpecific(access: .always, serviceName: "ExampleAppTests"))
    let card = Card(name: "Steve", number: "1234 5678 9012 3456")
    let user = User(username: "username", password: "password")
// usernmaes and passwrods are dummy data please change to fit your env.
    var distinctUsers: [User] {
        return [
            User(username: "email@test.com", password: "password"),
            User(username: "email@test.com", password: "password")
        ]
    }

    var identicalUsers: [User] {
        return [
            User(username: "emailOne@test.com", password: "p-onedummypassword"),
            User(username: "emailOne@test.com", password: "p-twodummypassword")
        ]
    }

    // MARK: Override

    override func setUp() {
        super.setUp()

        // Before running each test, check for an empty keychain.
        XCTAssertNil(try keychain.items(ofType: Card.self))
        XCTAssertNil(try keychain.items(ofType: User.self))
    }

    override func tearDown() {
        // Before running each test, clear the keychain.
        do {
            try keychain.deleteAll(ofType: Card.self)
            try keychain.deleteAll(ofType: User.self)
        } catch { fatalError("Error deleting all items.") }

        super.tearDown()
    }
}
