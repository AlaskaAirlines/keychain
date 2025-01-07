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

/// List of possible error cases thrown by **Keychain** operations.
public enum KeychainError: Error, Sendable {
    /// KeychainAccess search returned unexpected item data.
    ///
    /// - Note:
    ///   Only thrown when retrieving items from the **Keychain** fails due to **SecItemCopyMatching** query returning anything but an array of `[String: AnyObject]`.
    case unexpectedItemData

    /// Unhandled error returned by **Keychain** operation.
    ///
    /// For list of **OSStatus** codes, please see https://www.osstatus.com/
    case unhandled(OSStatus)
}
