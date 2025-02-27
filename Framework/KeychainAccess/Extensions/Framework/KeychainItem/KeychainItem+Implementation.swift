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

import Foundation

extension KeychainItem {
    /// - Note:
    ///   The default valus is **nil**.
    public var comment: String? {
        nil
    }

    /// - Note:
    ///   The default valus is **nil**.
    public var description: String? {
        nil
    }

    /// - Note:
    ///   The default valus is **false**.
    public static var isSynchronizable: Bool {
        false
    }

    /// - Note:
    ///   The default value is **.genericPassword**.
    ///
    ///   This **Keychain** framework only supports **kSecClassGenericPassword** for now.
    public static var storage: Keychain.Storage {
        .genericPassword
    }

    /// - Note:
    ///   The default value is the description of a type conforming to **KeychainItem** protocol.
    ///
    ///   ```
    ///   static var typeKey: String {
    ///       return String(describing: self)
    ///   }
    ///   ```
    public static var typeKey: String {
        String(describing: self)
    }

    /// - Note:
    ///   The default value is the encoded instance using the **PropertyListEncoder**.
    ///
    ///   ```
    ///   func data() throws -> Data {
    ///       return try PropertyListEncoder().encode(self)
    ///   }
    ///   ```
    public func data() throws -> Data {
        try PropertyListEncoder().encode(self)
    }
}
