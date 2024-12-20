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

public extension Keychain {
    /// List of supported setup options for configuring **Keychain**.
    enum SetupOption: Sendable {
        /// Will configure **Keychain** to be specific to each app.
        case appSpecific(access: AccessLevel, serviceName: String)

        /// Will configure **Keychain** to be specific to a group of apps.
        case groupSpecific(access: AccessLevel, accessGroup: String, serviceName: String)
    }
}

// MARK: - Setup & Configuration

internal extension Keychain.SetupOption {
    /// Configuration data for the **Keychain** instance.
    var configuration: Keychain.Configuration {
        switch self {
        case .appSpecific(let access, let serviceName):
            return Keychain.Configuration(access: access, serviceName: serviceName)

        case .groupSpecific(let access, let accessGroup, let serviceName):
            return Keychain.Configuration(access: access, accessGroup: accessGroup, serviceName: serviceName)
        }
    }
}
