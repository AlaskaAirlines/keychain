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

import Foundation

/// A type that can represent conforming model as a **KeychainItem**.
public protocol KeychainItem: Codable {
    /// The instance comment saved as an attribute on a **Keychain** item using **kSecAttrComment** key.
    var comment: String? { get }

    /// The instance description saved as an attribute on a **Keychain** item using **kSecAttrDescription** key.
    var description: String? { get }

    /// The instance identifier saved as an attribute on a **Keychain** item using **kSecAttrAccount** key.
    ///
    /// - Warning:
    ///   If you intend to store multiple instances of the same type, `idKey` must be unique to each instance.
    ///   Failing to do so will result in having previously saved instance maching this `idKey` overriden.
    ///
    /// - Consider this implementation:
    ///   ````
    ///   struct User: KeychainItem {
    ///       let email: String
    ///
    ///       // MARK: KeychainItem
    ///
    ///       var idKey: String {
    ///           return email
    ///       }
    ///   }
    ///   ````
    ///   In the above example, the `idKey` is set to be the email address of the user.
    ///   You can use the `idKey` later to perform a search like this:
    ///
    ///   ````
    ///   try keychain.item(ofType: User.self, idKey: "email@alaskaair.com")
    ///   ````
    ///
    ///   If only a single instance of a type will be stored, the `idKey` can be set using `typeKey`.
    ///
    ///   ````
    ///   struct SSOCredential: KeychainItem {
    ///       let accessToken: String
    ///
    ///       // MARK: KeychainItem
    ///
    ///       var idKey: String {
    ///           return SSOCredential.typeKey
    ///       }
    ///   }
    ///   ````
    var idKey: String { get }

    /// A boolean value indicating whether the item is synchronized through iCloud.
    ///
    /// Updating or deleting items will affect all copies of the item, not just the one on your local device.
    ///
    /// For more information when specifying **isSynchronizable** see Documentation for **kSecAttrSynchronizable** key.
    ///
    /// Setting `isSynchronizable` to `true` will enable iCloud sync.
    static var isSynchronizable: Bool { get }

    /// The storage option of the item for specifying **Keychain** storage type using **kSecClass** key.
    static var storage: Keychain.Storage { get }

    /// The type identifier saved as an attribute on a **Keychain** item using **kSecAttrType** key.
    /// Used for identifying instances of the same type.
    static var typeKey: String { get }

    /// The instance data saved as an attribute on a **Keychain** item using **kSecValueData** key.
    func data() throws -> Data
}
