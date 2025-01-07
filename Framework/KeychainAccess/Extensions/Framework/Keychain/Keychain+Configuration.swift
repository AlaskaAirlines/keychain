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

internal extension Keychain {
    /// A type that represents configuration object for the **Keychain** instance.
    struct Configuration: Sendable {
        /// The value indicates when a keychain item is accessible.
        internal let access: AccessLevel

        /// The access group if any.
        ///
        /// - Note:
        ///   Specifying an access group will ensure items are shared across multiple apps using app **id** prefix.
        ///   Not specifying an access group will create items specific to each app.
        ///
        /// - Requires:
        ///   A valid app **id** prefix (can be obtained from Apple Developer portal).
        internal let accessGroup: String?

        /// The service name for saving and retrieving data from the **Keychain**.
        ///
        /// - Note:
        ///   Can be set to any string. Typically reflects the app's name.
        internal let serviceName: String

        /// Creates a **Keychain** configuration given the provided parameters.
        ///
        /// - Parameters:
        ///   - access:      The value indicates when a keychain item is accessible.
        ///   - accessGroup: The access group if any.
        ///   - serviceName: The service name.
        internal init(access: Keychain.AccessLevel, accessGroup: String? = nil, serviceName: String) {
            self.access = access
            self.accessGroup = accessGroup
            self.serviceName = serviceName
        }
    }
}
