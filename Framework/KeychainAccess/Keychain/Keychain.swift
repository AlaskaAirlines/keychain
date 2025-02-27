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

// MARK: - Keychain

/// Provides and coordinates saving and retrieving data from the **Keychain**.
public struct Keychain: Sendable {
    // MARK: - Properties

    /// The setup option of the **Keychain**.
    public let option: Keychain.SetupOption

    /// The **Keychain** manager instance for saving, retrieving, and deleting **Keychain** data.
    private let manager: Keychain.Manager

    // MARK: - Lifecycle

    /// Creates a **Keychain** instance given the provided parameter(s).
    ///
    /// - Parameters:
    ///   - option: The setup option of the **Keychain**.
    public init(_ option: Keychain.SetupOption) {
        self.manager = Manager(configuration: option.configuration)
        self.option = option
    }
}

extension Keychain {
    /// Deletes item from the **Keychain**.
    ///
    /// - Parameters:
    ///   - item: The item to delete.
    ///
    /// - Throws: **KeychainError.unhandled** containing **OSStatus** code.
    public func delete(_ item: KeychainItem) throws {
        try manager.delete(item)
    }

    /// Deletes all items of specified type.
    ///
    /// - Note:
    ///   The implementation of this function directly relies on finding all item instances of specified type first.
    ///
    ///   For operation to be successful, make sure **Keychain** is configured using the correct **serviceName** and **accessGroup**.
    ///   Also, the following must be true:
    ///   - Instance **types** are the same.
    ///   - Instance **storage** types are the same.
    ///
    ///   For more information, see **KeychainItem+Query.swift** implementation.
    ///
    /// - Parameters:
    ///   - type: A generic type of the item.
    ///
    /// - Throws: **KeychainError.unhandled** containing **OSStatus** code.
    public func deleteAll<T: KeychainItem>(ofType type: T.Type) throws {
        try manager.deleteAll(ofType: type)
    }

    /// Saves item to the **Keychain**.
    ///
    /// - Note:
    ///   Saving an identical instance to the **Keychain** will first remove previously saved instance.
    ///
    ///   Item instances are considered identical when the **Keychain** is configured using the same **serviceName** and **accessGroup**.
    ///   Also, the following must be true:
    ///   - Instance **types** are the same.
    ///   - Instance **storage** types are the same.
    ///   - Instance **idKey** properties are the same.
    ///
    ///   For example, consider this implementation:
    ///   ```
    ///   struct User: KeychainItem {
    ///       let username: String
    ///       let password: String
    ///
    ///       // MARK: - KeychainItem
    ///
    ///       var idKey: String {
    ///           return username
    ///       }
    ///   }
    ///   ```
    ///   ```
    ///   let userOne = User(username: "user", password: "p-one")
    ///   let userTwo = User(username: "user", password: "p-two")
    ///   ```
    ///   Even though these are two distinct instances of **User** type containing different
    ///   passwords, **userTwo** will be treated as an identical to **userOne**.
    ///
    ///   For more information, see **KeychainItem+Query.swift** implementation.
    ///
    /// - Parameters:
    ///   - item: The item to save.
    ///
    /// - Throws: **KeychainError** if the operation fails.
    public func save(_ item: KeychainItem) throws {
        try manager.save(item)
    }

    /// Returns an item for specified account and service group using **idKey**.
    ///
    /// - Parameters:
    ///   - type:  A generic type of the item.
    ///   - idKey: The unique identifier of the item.
    ///
    /// - Throws: **KeychainError** if the operation fails.
    ///
    /// - Returns: A newly created item of T.Type if data is found for specified **idKey**, nil otherwise.
    public func item<T: KeychainItem>(ofType type: T.Type, idKey: String) throws -> T? {
        try manager.item(ofType: type, idKey: idKey)
    }

    /// Returns an array of items for specified account and service group.
    ///
    /// - Parameters:
    ///   - type: A generic type of the item.
    ///
    /// - Throws: **KeychainError** if the operation fails.
    ///
    /// - Returns: A newly created items array of T.Type if data is found, nil otherwise.
    public func items<T: KeychainItem>(ofType type: T.Type) throws -> [T]? {
        try manager.items(ofType: type)
    }
}
