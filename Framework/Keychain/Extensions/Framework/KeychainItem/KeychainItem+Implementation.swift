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

public extension KeychainItem {
    /// - Note:
    ///   The default valus is **nil**.
    var comment: String? {
        return nil
    }

    /// - Note:
    ///   The default valus is **nil**.
    var description: String? {
        return nil
    }

    /// - Note:
    ///   The default valus is **false**.
    static var isSynchronizable: Bool {
        return false
    }

    /// - Note:
    ///   The default value is **.genericPassword**.
    ///
    ///   This **Keychain** framework only supports **kSecClassGenericPassword** for now.
    static var storage: Keychain.Storage {
        return .genericPassword
    }

    /// - Note:
    ///   The default value is the description of a type conforming to **KeychainItem** protocol.
    ///
    ///   ````
    ///   static var typeKey: String {
    ///       return String(describing: self)
    ///   }
    ///   ````
    static var typeKey: String {
        return String(describing: self)
    }

    /// - Note:
    ///   The default value is the encoded instance using the **PropertyListEncoder**.
    ///
    ///   ````
    ///   func data() throws -> Data {
    ///       return try PropertyListEncoder().encode(self)
    ///   }
    ///   ````
    func data() throws -> Data {
        return try PropertyListEncoder().encode(self)
    }
}
