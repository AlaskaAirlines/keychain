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
//
// TODO: Add support for: kSecClassInternetPassword, kSecClassCertificate, kSecClassIdentity

import Foundation

public extension Keychain {
    /// List of supported storage options for **Keychain**.
    enum Storage {
        /// Item will be stored as encrypted, generic passwords.
        case genericPassword
    }
}

internal extension Keychain.Storage {
    /// C string value for a given Storage case.
    var kSecClass: CFString {
        switch self {
        case .genericPassword:
            return kSecClassGenericPassword
        }
    }
}
