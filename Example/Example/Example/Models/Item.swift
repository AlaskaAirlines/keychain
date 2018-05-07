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

import Foundation
import Keychain

/// Arbitrary item model object conforming to **KeychainItem** protocol.
struct Item: KeychainItem {

    // MARK: Properties

    /// The website address to save username and password for.
    let website: String

    /// The username to save for the entered website address.
    let username: String

    /// The password to save for the entered website address.
    let password: String

    // MARK: KeychainItem

    var idKey: String {
        return website
    }
}
