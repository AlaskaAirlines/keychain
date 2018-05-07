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

internal extension Keychain {
    /// Responsible for saving, deleting, and searching the **Keychain**.
    internal struct Manager {
        /// The **Keychain** configuration data derived from **Keychain.Access** type.
        private let configuration: Keychain.Configuration

        /// Creates a configuration instance given the provided parameter(s).
        ///
        /// - Parameters:
        ///   - configuration: The **Keychain** configuration data.
        internal init(configuration: Keychain.Configuration) {
            self.configuration = configuration
        }
    }
}

// MARK: Manager Interaction

internal extension Keychain.Manager {
    /// Deletes item from the **Keychain**.
    ///
    /// For documentation see: Keychain.delete()
    internal func delete(_ item: KeychainItem) throws {
        let query = try item.query(using: configuration).CFDictionary
        let status = SecItemDelete(query)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandled(status) }
    }
    
    /// Deletes all items of specified type.
    ///
    /// For documentation see: Keychain.deleteAll()
    internal func deleteAll<T: KeychainItem>(ofType type: T.Type) throws {
        try items(ofType: type)?.forEach { try delete($0) }
    }

    /// Saves item to the **Keychain**.
    ///
    /// For documentation see: Keychain.save()
    internal func save(_ item: KeychainItem) throws {
        // Try deleting previously saved item object matching this item query.
        try delete(item)

        // Add new item, store the result.
        let query = try item.query(using: configuration).CFDictionary
        let status = SecItemAdd(query, nil)

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandled(status) }
    }

    /// Returns an item for specified account and service group using **idKey**.
    ///
    /// For documentation see: Keychain.item()
    internal func item<T: KeychainItem>(ofType type: T.Type, idKey: String) throws -> T? {
        return try items(ofType: type)?.filter { $0.idKey == idKey }.first
    }

    /// Returns an array of items for specified account and service group.
    ///
    /// For documentation see: Keychain.items()
    internal func items<T: KeychainItem>(ofType type: T.Type) throws -> [T]? {
        let query = try type.query(using: configuration)

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query.CFDictionary, UnsafeMutablePointer($0))
        }

        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return nil }

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandled(status) }

        // Cast the query result to an array of dictionaries.
        guard let results = result as? [[String: AnyObject]] else { throw KeychainError.unexpectedItemData }

        // Convert an array of dictionaries into an array of T.
        return try results.compactMap {
            guard let data = $0[kSecValueData.string] as? Data else { return nil }

            return try PropertyListDecoder().decode(type, from: data)
        }
    }
}
