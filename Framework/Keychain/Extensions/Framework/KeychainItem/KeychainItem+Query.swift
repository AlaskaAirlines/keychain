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

internal extension KeychainItem {
    /// Creates and returns **KeychainQuery** instance object composed from configuration and item data.
    ///
    /// - Parameters:
    ///   - configuration: The configuration of the **Keychain**.
    ///
    /// - Returns: The **KeychainQuery** object.
    internal func query(using configuration: Keychain.Configuration) throws -> KeychainQuery {
        var query = KeychainQuery()
        query[kSecClass.string] = Self.storage.kSecClass
        query[kSecAttrSynchronizable.string] = Self.isSynchronizable.object
        query[kSecAttrType.string] = Self.typeKey.object

        query[kSecAttrAccount.string] = idKey.object
        query[kSecAttrComment.string] = comment?.object
        query[kSecAttrDescription.string] = description?.object
        query[kSecValueData.string] = try data().object

        // Values from configuration.
        query[kSecAttrService.string] = configuration.serviceName.object
        query[kSecAttrAccessGroup.string] = configuration.accessGroup?.object

        return query
    }

    /// Creates and returns **KeychainQuery** static object composed from configuration and item data.
    ///
    /// - Parameters:
    ///   - configuration: The configuration of the **Keychain**.
    ///
    /// - Returns: The **KeychainQuery** object.
    internal static func query(using configuration: Keychain.Configuration) throws -> KeychainQuery {
        var query = KeychainQuery()
        query[kSecClass.string] = Self.storage.kSecClass
        query[kSecAttrSynchronizable.string] = Self.isSynchronizable.object
        query[kSecAttrType.string] = Self.typeKey.object

        // Values from configuration.
        query[kSecAttrService.string] = configuration.serviceName.object
        query[kSecAttrAccessGroup.string] = configuration.accessGroup?.object

        // Additional values.
        query[kSecMatchLimit.string] = kSecMatchLimitAll
        query[kSecReturnAttributes.string] = kCFBooleanTrue
        query[kSecReturnData.string] = kCFBooleanTrue

        return query
    }
}
